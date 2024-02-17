# locals {
#   resourceGroup = [
#       {
#         id   = "/subscriptions/d253653b-a8b9-42b4-9e75-1b2b5dbee41b/resourceGroups/dev"
#         name = "dev"
#       },
#       {
#         id   = "/subscriptions/d253653b-a8b9-42b4-9e75-1b2b5dbee41b/resourceGroups/dev1"
#         name = "dev1"
#       }
#   ]

#   resourceGroup_name = {
#         name = "dev",
#         name = "dev1"
#   }
# }

# import {
#   for_each = local.resourceGroup
#   to = azurerm_resource_group.resource_group[each.value.name]
#   id = each.value.id
# }



# # import {

# #   for_each = local.resourceGroup
# #   to       = azurerm_resource_group.resource_group[each.value.name]
# #   id       = each.value.id
# # }

# resource "azurerm_resource_group" "resource_group" {
#   for_each = local.resourceGroup_name
#   name     = each.value
#   location = "estus"
# }


  
# output "resource_group"{
#   value = { for i, resourceGroup in local.resourceGroup : "name-${i}" => resourceGroup }
# }

# output "resource_group_name"{
#   value = { for i, resourceGroup in local.resourceGroup : "name-${i}" => resourceGroup.name }
# }