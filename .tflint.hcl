# TFLint configuration - shared by GitHub Actions (test) and Azure DevOps (target)
config {
  # "all" = also inspect local AND remote module calls (needs `terraform init` first);
  # "local" = only modules in this repo (no terraform init needed)
  call_module_type = "local"
}

# Built-in Terraform language rules
plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

# Azure Resource Manager (azurerm) provider rules
plugin "azurerm" {
  enabled = true
  version = "0.32.0"
  source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}
