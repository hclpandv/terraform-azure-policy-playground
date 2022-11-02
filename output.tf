output "output_values" {
  value = {
    "Allowed Location" = local.policy_definition_map.Allowed_locations
    "Allowed virtual machine size SKUs" = local.policy_definition_map.Allowed_virtual_machine_size_SKUs
  }
}

output "allowed_locations_policy_definitions" {
  value = data.azurerm_policy_definition.allowed_locations_policy_definitions
}