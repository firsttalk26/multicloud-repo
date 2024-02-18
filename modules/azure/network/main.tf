resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  tags = var.tags

  }


resource "azurerm_subnet" "subnet" {
  name                 = "${var.name}-${var.subnet.name}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet.address

}



resource "azurerm_network_security_group" "securitygroup" {
  name                = "${var.securityGroup.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_rule" "securitygroup_rule" {

  count                       = length(var.securityGroup.rule)
  name                        = var.securityGroup.rule[count.index].name
  priority                    = var.securityGroup.rule[count.index].priority
  direction                   = var.securityGroup.rule[count.index].direction
  access                      = var.securityGroup.rule[count.index].access
  protocol                    = var.securityGroup.rule[count.index].protocol
  source_port_range           = var.securityGroup.rule[count.index].source_port_range
  destination_port_range      = var.securityGroup.rule[count.index].destination_port_range
  source_address_prefix       = var.securityGroup.rule[count.index].source_address_prefix
  destination_address_prefix  = var.securityGroup.rule[count.index].destination_address_prefix
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.securitygroup.name
}


resource "azurerm_subnet_network_security_group_association" "securitygroup_association" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.securitygroup.id
}
  
