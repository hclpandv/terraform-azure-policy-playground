# data "azurerm_management_group" "main" {
#   name = "00000000-0000-0000-0000-000000000000"
# }

locals {
  subscription_id = "8bfff7c4-6972-4035-88a4-0e0121080864"
  list_of_rg_ids = toset([ 
    "/subscriptions/${local.subscription_id}/resourceGroups/rg-tf-viki-policy-tests01",
    "/subscriptions/${local.subscription_id}/resourceGroups/rg-tf-viki-policy-tests02",
    "/subscriptions/${local.subscription_id}/resourceGroups/rg-tf-viki-policy-tests03"
  ])
  # list_of_subscription_ids = data.azurerm_management_group.main.subscription_ids
}



#-------------------------------------------
# Built-In Policy assignment to multiple RGs
#-------------------------------------------
resource "azurerm_resource_group_policy_assignment" "built_in_assignments" {
  for_each             = local.list_of_rg_ids
  name                 = "pol-ass-ccoe-built-in-allowed-virtual-machine-size-SKUs-${element(split("/",each.key),length(split("/",each.key))-1)}"
  resource_group_id    = each.key
  policy_definition_id = local.policy_definition_map.Allowed_virtual_machine_size_SKUs
  parameters = jsonencode({
      listOfAllowedSKUs = {
        "value": ["standard_b2ms","standard_b2s","standard_d2as_v4"]
      }
  })
}
