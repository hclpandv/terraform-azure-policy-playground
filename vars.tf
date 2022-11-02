#-------------------------------------
# vars for Resource Groups
#-------------------------------------
variable "rg_main" {
  type        = string
  description = "rg name for resources"
  default     = "rg-tf-viki-policy-tests01"
}

variable "location" {
  type        = string
  description = "Azure region to deploy all resources"
  default     = "westeurope"
  validation {
    condition     = var.location == "westeurope" || var.location == "northeurope"
    error_message = "Sorry but we only accept location as west or north europe."
  }
}
#-----------------------------------------
# vars for network services. VNET/SNET etc
#-----------------------------------------
variable "vnet_name" {
  type        = string
  description = "name of main vnet for network resources"
  default     = "vnet-topgun-weu-01"
}

variable "vnet_cidr" {
  type        = string
  description = "cidr of the vnet"
  default     = "192.169.0.0/22"
}

