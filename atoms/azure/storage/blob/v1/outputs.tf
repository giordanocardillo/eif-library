output "primary_web_endpoint"  { description = "Static website primary endpoint."  ; value = azurerm_storage_account.this.primary_web_endpoint }
output "primary_blob_endpoint" { description = "Blob service primary endpoint."     ; value = azurerm_storage_account.this.primary_blob_endpoint }
output "storage_account_name"  { description = "The storage account name."          ; value = azurerm_storage_account.this.name }
