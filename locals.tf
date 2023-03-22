locals {
  default_tags = {
    deployedby = "Terraform"
    provider   = "azr"
  }
  tags = merge(var.tags, local.default_tags)
}