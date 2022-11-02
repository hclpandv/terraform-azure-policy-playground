#----Creating a resourceGroup for network resources
data "azurerm_resource_group" "main" {
  name = "rg-tf-viki-policy-tests01"
}
