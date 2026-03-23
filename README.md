<!-- EIF Library — Component Library for the Elemental Infrastructure Framework -->
<div align="center">

<pre>
  E L E M E N T A L
I N F R A S T R U C T U R E
 F R A M E W O R K
</pre>

[![License: Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-4af0c4?style=flat-square)](LICENSE)
[![Terraform](https://img.shields.io/badge/Terraform-≥1.5-3a8fff?style=flat-square&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-supported-3a8fff?style=flat-square&logo=amazonaws&logoColor=white)]()
[![Azure](https://img.shields.io/badge/Azure-supported-3a8fff?style=flat-square&logo=microsoftazure&logoColor=white)]()
[![GCP](https://img.shields.io/badge/GCP-supported-3a8fff?style=flat-square&logo=googlecloud&logoColor=white)]()
[![Status](https://img.shields.io/badge/Status-WIP-f0884a?style=flat-square)]()
[![CLI](https://img.shields.io/badge/CLI-eif-4af0c4?style=flat-square)](https://github.com/giordanocardillo/eif)

**The official component library for the [Elemental Infrastructure Framework](https://github.com/giordanocardillo/eif).**

[Structure](#-structure) · [Atoms](#-atoms) · [Molecules](#-molecules) · [Usage](#-usage) · [Versioning](#-versioning) · [Contributing](#-contributing)

</div>

---

## ◈ Overview

This repository contains the atoms and molecules used by [eif](https://github.com/giordanocardillo/eif) to compose and deploy cloud infrastructure. It is not meant to be used standalone — the `eif` CLI renders these components into deployable Terraform configurations.

Atoms are primitive, single-service building blocks. Molecules combine atoms into coherent architectural patterns. Neither is deployed directly — that is the role of **matters**, which live in your own library repository alongside an `accounts.json`.

---

## ◫ Structure

```
eif-library/
├── atoms/
│   ├── aws/
│   │   ├── networking/cloudfront/v1/
│   │   ├── security/waf/v1/
│   │   └── storage/s3/v1/
│   ├── azure/
│   │   ├── networking/frontdoor/v1/
│   │   └── storage/blob/v1/
│   └── gcp/
│       ├── networking/cdn/v1/
│       ├── security/armor/v1/
│       └── storage/gcs/v1/
└── molecules/
    ├── aws/single-page-application/v1/
    ├── azure/single-page-application/v1/
    └── gcp/single-page-application/v1/
```

---

## ◉ Atoms

Atoms are the primitive layer — one cloud service per atom. They are generic by design: no hardcoded use-case assumptions. All SPA-specific behaviour (static website hosting, public read access, default root object) is opt-in via variables.

### AWS

| Atom | Path | Description |
|---|---|---|
| `s3` | `atoms/aws/storage/s3/v1` | S3 bucket with versioning and full public access block. Optionally grants a CloudFront distribution access via OAC bucket policy. |
| `waf` | `atoms/aws/security/waf/v1` | WAFv2 WebACL with a single AWS managed rule group. Scope is configurable (`CLOUDFRONT` or `REGIONAL`). |
| `cloudfront` | `atoms/aws/networking/cloudfront/v1` | CloudFront distribution with OAC-based S3 origin, HTTPS redirect, and optional WAF. Default root object is configurable. |

### Azure

| Atom | Path | Description |
|---|---|---|
| `blob` | `atoms/azure/storage/blob/v1` | Azure Storage Account with TLS 1.2 enforced and HTTPS-only traffic. Static website hosting is opt-in. |
| `frontdoor` | `atoms/azure/networking/frontdoor/v1` | Azure Front Door profile, endpoint, origin group, and route. Enforces HTTPS with automatic HTTP→HTTPS redirect. |

### GCP

| Atom | Path | Description |
|---|---|---|
| `gcs` | `atoms/gcp/storage/gcs/v1` | GCS bucket with uniform bucket-level access. Website configuration and public read IAM are opt-in. |
| `armor` | `atoms/gcp/security/armor/v1` | Cloud Armor security policy with a default allow rule and dynamic IP block rules. |
| `cdn` | `atoms/gcp/networking/cdn/v1` | Global HTTPS load balancer backed by a GCS bucket. Includes Google-managed SSL certificate, HTTP→HTTPS redirect, shared static IP, and optional Cloud Armor policy. |

---

## ◈ Molecules

Molecules wire atoms together into a deployable architectural pattern. Each molecule is the unit referenced by a matter's `composition.json`.

### `single-page-application`

A globally distributed static web application with CDN, HTTPS, and edge security. Available for AWS, Azure, and GCP.

| Cloud | Path | Atoms | Dependency chain |
|---|---|---|---|
| AWS | `molecules/aws/single-page-application/v1` | `s3` + `waf` + `cloudfront` | `cloudfront` ← `s3.bucket_regional_domain_name`, `waf.web_acl_arn` · `s3` bucket policy ← `cloudfront.distribution_arn` |
| Azure | `molecules/azure/single-page-application/v1` | `blob` + `frontdoor` | `frontdoor` ← `blob.primary_web_endpoint` |
| GCP | `molecules/gcp/single-page-application/v1` | `gcs` + `armor` + `cdn` | `cdn` ← `gcs.bucket_name`, `armor.policy_self_link` |

#### AWS inputs

| Variable | Description | Default |
|---|---|---|
| `environment` | Deployment environment | — |
| `bucket_name` | S3 bucket name | — |
| `s3_versioning_enabled` | Enable S3 versioning | `false` |
| `cloudfront_price_class` | CloudFront price class | `PriceClass_100` |
| `waf_name` | WAF WebACL name | `swa-waf` |
| `waf_managed_rule_group` | AWS managed rule group | `AWSManagedRulesCommonRuleSet` |

#### AWS outputs

| Output | Description |
|---|---|
| `cloudfront_domain` | Public domain of the CloudFront distribution |
| `s3_bucket_id` | S3 origin bucket name |
| `waf_web_acl_arn` | WAF WebACL ARN |

#### Azure inputs

| Variable | Description | Default |
|---|---|---|
| `environment` | Deployment environment | — |
| `resource_group_name` | Azure resource group | — |
| `location` | Azure region | — |
| `storage_account_name` | Storage account name (3–24 chars) | — |
| `account_tier` | Storage tier | `Standard` |
| `account_replication_type` | Replication type | `LRS` |
| `frontdoor_profile_name` | Front Door profile name | — |
| `frontdoor_endpoint_name` | Front Door endpoint name | — |
| `frontdoor_sku_name` | Front Door SKU | `Standard_AzureFrontDoor` |

#### Azure outputs

| Output | Description |
|---|---|
| `frontdoor_endpoint_hostname` | Front Door endpoint hostname |
| `storage_account_name` | Storage account name |
| `primary_web_endpoint` | Static website endpoint |

#### GCP inputs

| Variable | Description | Default |
|---|---|---|
| `environment` | Deployment environment | — |
| `bucket_name` | GCS bucket name | — |
| `location` | Bucket location (e.g. `US`, `EU`) | — |
| `cdn_name` | Base name for CDN and load balancer resources | — |
| `domains` | Domains for Google-managed SSL certificate | — |
| `armor_policy_name` | Cloud Armor security policy name | — |
| `blocked_ip_ranges` | CIDR ranges to deny (403) | `[]` |

#### GCP outputs

| Output | Description |
|---|---|
| `ip_address` | Static IP — point your DNS A record here |
| `bucket_name` | GCS static assets bucket name |
| `armor_policy_name` | Cloud Armor policy name |
| `ssl_certificate_id` | Google-managed SSL certificate ID |

---

## ▶ Usage

This library is consumed by the `eif` CLI. In your library repository, reference molecules from `composition.json`:

```json
{
  "matter": "my-app",
  "molecules": [
    { "name": "single-page-application", "source": "molecules/aws/single-page-application/v1" }
  ]
}
```

Then render and deploy:

```bash
eif plan aws my-app dev
eif apply aws my-app dev
```

See the [eif CLI](https://github.com/giordanocardillo/eif) for the full deployment lifecycle.

---

## ◑ Versioning

Atoms and molecules follow a `v1/`, `v2/`, … versioning scheme. Breaking changes (removed variables, changed output names, restructured resources) always get a new version directory. Bug fixes and new optional variables are applied in place.

Molecule sources are pinned in `composition.json`. To upgrade all pinned versions to the latest available:

```bash
eif upgrade aws my-app dev
```

---

## ⬡ Contributing

### Scaffolding with the eif CLI

The fastest way to add a new atom or molecule is via `eif new`, which generates the correct directory structure and starter files automatically:

```bash
# scaffold a new atom (prompts: name, provider, category)
eif new atom
eif new atom my-service       # name pre-filled

# scaffold a new molecule (prompts: name, provider)
eif new molecule
eif new molecule my-service
```

Run these commands from inside this repository. `eif` detects the existing providers from `providers/`, checks for existing versions, and creates the next version if the atom or molecule already exists (e.g. `v2/`). Each scaffold emits starter `main.tf`, `variables.tf`, and `outputs.tf` ready to be filled in.

### Conventions

- One service per atom. No use-case assumptions — keep atoms generic.
- Place atoms under `atoms/<cloud>/<category>/<name>/v1/` with `main.tf`, `variables.tf`, and `outputs.tf`.
- Place molecules under `molecules/<cloud>/<name>/v1/` with the same three files.
- Use `ManagedBy = "eif"` / `managed_by = "eif"` tags where supported.
- Open an issue before submitting large structural changes.

---

## ◈ License

Apache 2.0 © [Giordano Cardillo](https://github.com/giordanocardillo)

---

<div align="center">
<sub>EIF Library · Atoms & Molecules · AWS · Azure · GCP</sub>
</div>
