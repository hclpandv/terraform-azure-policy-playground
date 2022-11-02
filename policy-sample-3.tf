#-------------------------------------
# Built-In Policy assignment to RG
#-------------------------------------
resource "azurerm_resource_group_policy_assignment" "built_in_assignment_01" {
  name                 = "pol-ass-built-in-allowed-virtual-machine-size-SKUs"
  resource_group_id    = data.azurerm_resource_group.main.id
  policy_definition_id = local.policy_definition_map.Allowed_virtual_machine_size_SKUs
  parameters = jsonencode({
      listOfAllowedSKUs = {
        "value": ["standard_b2ms","standard_b2s","standard_d2as_v4"]
      }
  })
}

resource "azurerm_resource_group_policy_assignment" "built_in_assignment_02" {
  name                 = "pol-ass-built-in-allowed-resource-locations"
  resource_group_id    = data.azurerm_resource_group.main.id
  policy_definition_id = data.azurerm_policy_definition.allowed_locations_policy_definitions.id
  parameters = jsonencode({
      listOfAllowedLocations = {
        "value": ["westeurope","northeurope"]
      }
  })
}