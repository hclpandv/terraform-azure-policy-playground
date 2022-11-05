locals {
  # policy_files = fileset("${path.module}/custom-policies/**", "policy-rule.json")
  # policy_details = [for s in local.policy_files : slice(split("/","${s}"),2,4)] 
}

#-------------------------------------
# All Policy definitions (for_each)
#-------------------------------------
resource "azurerm_policy_definition" "all_policy_definitions" {
  for_each     = fileset("${path.module}/custom-policies/**", "policy-rule.json")
  name         = "${element(split("/",each.value),2)}"  
  metadata = <<METADATA
    {
    "category": "${element(split("/",each.value),1)}",
    "version" : "1.0.0"
    }
METADATA
  policy_type  = "Custom"
  mode         = "All"
  display_name = "${element(split("/",each.value),2)}"
  policy_rule  = file("${path.module}/custom-policies/${substr(each.value, 3, length(each.value)-20)}/policy-rule.json")
  parameters   = file("${path.module}/custom-policies/${substr(each.value, 3, length(each.value)-20)}/policy-parameters.json")
}
