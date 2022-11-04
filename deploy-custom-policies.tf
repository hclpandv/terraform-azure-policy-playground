locals {
  #category     = concat(aws_instance.ec1.*.id, aws_instance.ec3.*.id)
  category     = fileset("${path.module}/custom-policies", "*.*")
  name         = "${path.module}/custom-policies/general/resource-location/policy-rule.json"
  display_name = "" 
  env          = "dev"
}