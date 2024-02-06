locals {
  resourceGroup = [
      {
        id   = "/subscriptions/<subscription id>/resourceGroups/dev"
        name = "dev"
      },
      {
        id   = "/subscriptions/<subscription id>/resourceGroups/dev1"
        name = "dev1"
      }
  ]
}



# import {

#   for_each = local.resourceGroup
#   to       = azurerm_resource_group.resource_group[each.value.name]
#   id       = each.value.id
# }

# resource "azurerm_resource_group" "resource_group" {
#   count    = length(local.resourceGroup.resource) ? length(local.resourceGroup.resource) : 0
#   name     = each.value.name
#   location = var.location
# }

  
output "resource_group"{
  value = { for i, resourceGroup in local.resourceGroup : "name-${i}" => resourceGroup }
}

output "resource_group_name"{
  value = { for i, resourceGroup in local.resourceGroup : "name-${i}" => resourceGroup.name }
}