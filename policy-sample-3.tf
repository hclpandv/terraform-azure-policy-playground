#-------------------------------------
# Built-In Policy assignment to RG
#-------------------------------------
resource "azurerm_resource_group_policy_assignment" "built_in_assignment" {
  name                 = "pol-ass-built_in_allowed-resource-locations"
  resource_group_id    = data.azurerm_resource_group.main.id
  policy_definition_id = local.policy_definition_map.Allowed_locations
  #policy_definition_id = data.azurerm_policy_definition.allowed_locations_policy_definitions.id

  parameters = <<PARAMS
    {
      "allowedLocations": {
        "value": ["westeurope","northeurope"]
      }
    }
PARAMS
}
