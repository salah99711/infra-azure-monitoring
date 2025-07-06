resource "azurerm_resource_group" "rg" {
  name     = "rg-monitoring"
  location = "francecentral"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-monitoring"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-main"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
