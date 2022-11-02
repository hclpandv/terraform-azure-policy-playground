#-------------------------------------
# Policy definition
#-------------------------------------
resource "azurerm_policy_definition" "main" {
  name         = "pol-def-ccoe-allowed-resource-locations"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "only-deploy-in-westeurope-policy-definition"
  policy_rule  = file("${path.module}/custom-policies/resource-location/policy-rule.json")
  parameters   = file("${path.module}/custom-policies/resource-location/policy-parameters.json")
}
#-------------------------------------
# Policy assignment to RG
#-------------------------------------
resource "azurerm_resource_group_policy_assignment" "main" {
  name                 = "pol-ass-ccoe-allowed-resource-locations"
  resource_group_id    = data.azurerm_resource_group.main.id
  policy_definition_id = azurerm_policy_definition.main.id

  parameters = <<PARAMS
    {
      "allowedLocations": {
        "value": ["westeurope","northeurope"]
      }
    }
PARAMS
}
