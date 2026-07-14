resource "azurerm_resource_group" "resource_group" {
  count    = var.count  
  name     = format("rg-%s-%s-%s-%03d", var.application, var.environment, var.location, count.index + 1)
  location = var.location

  tags = var.tags
}

