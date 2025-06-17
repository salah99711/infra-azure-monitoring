# =======================
# Variables communes
# =======================
variable "admin_username" {
  default = "azureuser"
}

variable "ssh_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCn2PQb0CmFFqfewBGPr830Ncb3riK9slutDLJA1EugNRbyO8ZvlpPGITla8i22FqsMP9o0Z6Ung5k2RehibH5EkkgQAlo60q2vEwMeZmnaU9RXKPF/PyqP+HbjCLXrwahSAjsc3G5omJL9WMKOYQsAWUlGQ/PDEQKK/VJqsGBQSHx0RRYT08spFob+eIFlv4BW3ykSs1LSxNfw0oTj38VCbIoc2zcT/3J9v57wvMmuKkAF2MKbx7mZei1o6QSH6H3CcrTYNcOToPsPGSWvG9m90CgOOcLi0jrVBJF4WAPOMyOj6xBmPCQjzw1mgHdnpi9AAA6VxlbyVvu8HEQZybhuWY7+8vCHJ6eMN6Tm7TUc9FFPtj+D647b+Qt+EkNzSdXE8GOrhpuGzsEwWJI7rQcHVLxSm/ECu4+cvx1fwroboCrkc75sngb/gOW/nv2qKggneeqwgscAY+KCJI9UeM2aUnqTIfsju1QKwd0YHi4zmQCiR/QHVvtMQT819qPBVzajnT1r2Z3wpXUnPg51dwoWDIcqfwNAofCr5hLAcrh0chQqZO43f7CTnXcGZTEvZ7cXzR8eDzfcAWknSUQskHRrJQZqilDyHvBn3cgl04JK4cN4G17d1liVE2NeThGrchb8GvK/OGKfKChI699d8HY3Mkq4es2Ivj2qJeFPQRf5vQ== salah@salah-VMware-Virtual-Platform"
}


# =======================
# VM Web
# =======================
resource "azurerm_public_ip" "web_ip" {
  name                = "web-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Basic"
}

resource "azurerm_network_interface" "web_nic" {
  name                = "web-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "web-ip-config"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm_web" {
  name                            = "vm-web"
  location                        = azurerm_resource_group.rg.location
  resource_group_name             = azurerm_resource_group.rg.name
  network_interface_ids           = [azurerm_network_interface.web_nic.id]
  size                            = "Standard_B1s"
  admin_username                  = var.admin_username
  disable_password_authentication = true

  os_disk {
    name                 = "disk-web"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_key
  }
}

# =======================
# VM Monitoring
# =======================
resource "azurerm_public_ip" "mon_ip" {
  name                = "mon-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Basic"
}

resource "azurerm_network_interface" "mon_nic" {
  name                = "mon-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "mon-ip-config"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mon_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm_mon" {
  name                            = "vm-monitoring"
  location                        = azurerm_resource_group.rg.location
  resource_group_name             = azurerm_resource_group.rg.name
  network_interface_ids           = [azurerm_network_interface.mon_nic.id]
  size                            = "Standard_B1s"
  admin_username                  = var.admin_username
  disable_password_authentication = true

  os_disk {
    name                 = "disk-mon"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_key
  }
}
