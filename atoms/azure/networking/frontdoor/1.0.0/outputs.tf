output "endpoint_hostname" { description = "The Front Door endpoint hostname." ; value = azurerm_cdn_frontdoor_endpoint.this.host_name }
output "endpoint_id"       { description = "The Front Door endpoint ID."       ; value = azurerm_cdn_frontdoor_endpoint.this.id }
output "profile_id"        { description = "The Front Door profile ID."        ; value = azurerm_cdn_frontdoor_profile.this.id }
