# Matrix
locals {
  vm_disks = merge([
    for i in range(var.count) : {
      for k, v in var.data_disk :
        "${i}-${k}" => {
          vm_index            = i
          name                = k
          disk_size_gb        = v
        }
    }
  ])
}

resource "azurerm_network_interface" "nic" {
  count               = var.count
  name                = format("nic-%s-%s-%s-%03d", var.application, var.environment, var.location, count.index + 1)
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

resource "azurerm_managed_disk" "data_disk" {
  for_each           = local.vm_disks
  name                = format("${each.value.name}-%s-%s-%s-%03d", var.application, var.environment, var.location, each.value.vm_index + 1)
  location            = var.location
  resource_group_name = var.resource_group_name
  create_option       = var.data_disk_create_option
    disk_size_gb        = each.value.disk_size_gb
  storage_account_type = var.data_disk_storage_account_type

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  count = var.count 
  name                = format("vm-%s-%s-%s-%03d", var.application, var.environment, var.location, count.index + 1)
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  
  os_disk {
    name = format("C-%s-%s-%s-%03d", var.application, var.environment, var.location, count.index + 1)
    disk_size_gb        = var.os_disk_size_gb
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.version
  }

  tags = var.tags

  depends_on = [azurerm_network_interface[count.index].nic]
}

