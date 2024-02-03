terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.90.0"
    }
  }
}



# Use the selected provider based on the value of the 'cloud_provider' variable

# provider "google" {

#   credentials = file(var.gcp_credentials_file)
#   project     = var.gcp_project
#   region      = var.gcp_region
#   zone        = var.gcp_zone

# }

# provider "aws" {
#   alias  = "aws"
#   region = "us-west-2"

# }


provider "azurerm" {
  features {}
  tenant_id       = var.ARM_TENANT_ID
  client_id       = var.ARM_CLIENT_ID
  subscription_id = var.ARM_SUBSCRIPTION_ID
  client_secret   = var.ARM_CLIENT_SECRET
}



module "azure_rg" {
  source   = "./modules/azure/resource-group"
  name     = var.azure_resources.resource_group.name
  location = var.azure_resources.resource_group.location
  enable   = var.azure_resources.resource_group.enable
}
