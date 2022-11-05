#-------------------------------------
# Policy definition
#-------------------------------------
resource "azurerm_policy_definition" "example" {
  name         = "pol-def-ccoe-allow-resource-only-in-westeurope"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "pol-def-ccoe-allow-resource-only-in-westeurope"

  policy_rule = <<POLICY_RULE
 {
    "if": {
      "not": {
        "field": "location",
        "equals": "westeurope"
      }
    },
    "then": {
      "effect": "Deny"
    }
  }
POLICY_RULE
}
#-------------------------------------
# Policy assignment to RG
#-------------------------------------
resource "azurerm_resource_group_policy_assignment" "example" {
  name                 = "pol-ass-ccoe-allow-resource-only-in-westeurope-${data.azurerm_resource_group.main.name}"
  resource_group_id    = data.azurerm_resource_group.main.id
  policy_definition_id = azurerm_policy_definition.example.id
}