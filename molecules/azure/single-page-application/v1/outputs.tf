output "frontdoor_endpoint_hostname" { description = "The Front Door endpoint hostname." ; value = module.frontdoor.endpoint_hostname }
output "storage_account_name"        { description = "The storage account name."         ; value = module.blob.storage_account_name }
output "primary_web_endpoint"        { description = "The static website endpoint."      ; value = module.blob.primary_web_endpoint }
