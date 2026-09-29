# Deliberately "bad" Terraform so we can prove TFLint catches issues.
# Expected findings are noted in the comments.

terraform {
  # Missing required_version        -> terraform_required_version
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      # Missing version constraint  -> terraform_required_providers
    }
  }
}

provider "azurerm" {
  features {}
}

variable "location" {
  type    = string
  default = "uksouth"
}

variable "not_used" {             # -> terraform_unused_declarations
  type = string
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-tflint-test"
  location = "${var.location}"    # -> terraform_deprecated_interpolation
}

resource "azurerm_storage_account" "sa" {
  name                     = "Invalid_Storage_Name"  # -> azurerm_storage_account_invalid_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier              = "Lukewarm"              # -> azurerm_storage_account_invalid_access_tier
}
