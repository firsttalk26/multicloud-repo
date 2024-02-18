terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
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


module "azure_network" {
  source   = "./modules/azure/network"
  name = var.azure_resources.network_setting.vnet_name
  location = module.azure_rg.resource_group_location == null ? var.azure_resources.network_setting.location : module.azure_rg.resource_group_location
  resource_group_name=module.azure_rg.resource_group_name == null ? var.azure_resources.network_setting.resource_group_name : module.azure_rg.resource_group_name
  address_space = var.azure_resources.network_setting.address_space
  tags = var.azure_resources.network_setting.tags
  subnet = var.azure_resources.network_setting.subnet
  securityGroup = var.azure_resources.network_setting.securityGroup
  depends_on = [module.azure_rg]
}

