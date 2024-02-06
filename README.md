# multicloud-repo


## Azure

### Authentication

Authenticate terraform using service principal and client secret on Azure.

#### Run below command to create service principal.
```
az ad sp create-for-rbac --name <service_principal_name> --role Contributor --scopes /subscriptions/<subscription_id>

```

#### Add below variables in .auto.tfvars file.
```
ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
ARM_TENANT_ID="<azure_subscription_tenant_id>"
ARM_CLIENT_ID="<service_principal_appid>"
ARM_CLIENT_SECRET="<service_principal_password>"

```

#### Configuration of Existing resource is generated using import block as below.

```
import {
  to = azurerm_resource_group.resource_group
  id = "/subscriptions/<subscription-id>/resourceGroups/<resource group name>"
}

```

##### Variables Type

```
string  
number  
boolean 
list   
map     
set 
```

##### Retrive variable value as output using loop


```
locals {
  resourceGroup = [
      {
        id   = "/subscriptions/<subscription id>/resourceGroups/dev"
        name = "dev"
      }
  ]
}

output "resource_group"{
  value = { for i, resourceGroup in local.resourceGroup : "name-${i}" => resourceGroup }
}

```

###### Terraform automatically converts number and bool values to strings when needed. It also converts strings to numbers or bools, as long as the string contains a valid representation of a number or bool value

##### Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

* Environment variables
* The terraform.tfvars file, if present.
* The terraform.tfvars.json file, if present.
* Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
* Any -var and -var-file options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace.)