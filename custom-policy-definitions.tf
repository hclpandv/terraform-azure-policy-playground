locals {
  policy_files = fileset("${path.module}/custom-policies/*/*", "policy-rule.json")
  policy_details = [for s in local.policy_files : slice(split("/","${s}"),2,4)] 
}

#-------------------------------------
# All Policy definitions (for_each)
#-------------------------------------
# resource "azurerm_policy_definition" "all_policy_definitions" {
#   for_each     = local.policy_details
#   name         = element(each.key,1)
#   metadata = <<METADATA
#     {
#     "category": "${element(each.key,2)}",
#     "version" : "1.0.0"
#     }
# METADATA
#   policy_type  = "Custom"
#   mode         = "All"
#   display_name = element(each.key,1)
#   policy_rule  = file("${path.module}/custom-policies/${element(each.key,2)}/${element(each.key,1)}/policy-rule.json")
#   parameters   = file("${path.module}/custom-policies/${element(each.key,2)}/${element(each.key,1)}/policy-parameters.json")
# }
