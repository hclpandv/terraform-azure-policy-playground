resource "azurerm_policy_definition" "example" {
  name         = "only-deploy-in-westeurope"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "my-policy-definition"

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

resource "azurerm_resource_group_policy_assignment" "example" {
  name                 = "example"
  resource_group_id    = data.azurerm_resource_group.main.id
  policy_definition_id = azurerm_policy_definition.example.id

#   parameters = <<PARAMS
#     {
#       "tagName": {
#         "value": "Business Unit"
#       },
#       "tagValue": {
#         "value": "BU"
#       }
#     }
# PARAMS
}