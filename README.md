# terraform-azure-policy-playground

* To do
1. Add meta data to add category in policy definition

```hcl
  metadata = <<METADATA
    {
    "category": "${var.policy_definition_category}",
    "version" : "1.0.0"
    }
METADATA
```
2. All custom policy to be deployed via a single tf file. 