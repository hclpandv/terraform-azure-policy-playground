data "azurerm_subscription" "current" {}

#-------------------------------------
# All Policy definitions (for_each)
#-------------------------------------
resource "azurerm_policy_definition" "all" {
  for_each     = fileset("${path.module}/custom-policies/**", "policy-rule.json")
  name         = "${element(split("/",each.value),2)}"  
  metadata     = jsonencode({
      category = "${element(split("/",each.value),1)}",
      version = var.policy_version
  }) 
  policy_type  = "Custom"
  mode         = "All"
  display_name = "${element(split("/",each.value),2)}"
  policy_rule  = file("${path.module}/custom-policies/${substr(each.value, 3, length(each.value)-20)}/policy-rule.json")
  parameters   = file("${path.module}/custom-policies/${substr(each.value, 3, length(each.value)-20)}/policy-parameters.json") == jsonencode({}) ? null : file("${path.module}/custom-policies/${substr(each.value, 3, length(each.value)-20)}/policy-parameters.json")
  
}

#-------------------------------------
# Policy assignments to subscription
#-------------------------------------
resource "azurerm_subscription_policy_assignment" "all" {
  for_each = azurerm_policy_definition.all

  name                 = "subscription-${each.value.name}"
  policy_definition_id = each.value.id
  subscription_id      = data.azurerm_subscription.current.id
  parameters           = file("${path.module}/custom-policies/${substr(each.key, 3, length(each.key)-20)}/values.json") == jsonencode({}) ? null : file("${path.module}/custom-policies/${substr(each.key, 3, length(each.key)-20)}/values.json")
}
