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
  features {
    
  }
}

locals {

  /*provider_alias = regexall("aws", var.cloud_provider) ? "aws" :  regexall("gcp", var.cloud_provider) ? "google" : regexall("azure", var.cloud_provider) ? "azure": 0
*/
  provider_alias = var.cloud_provider == "aws" ? "aws" : var.cloud_provider == "google" ? "google" : var.cloud_provider == "azure" ? "azure" : 0

}