variable "count" {
  description = "Number of virtual machines to create"
  type        = number
  default     = 1
}

variable "application" {
  description = "Application name for naming resources"
  type        = string
}

variable "environment" {
  description = "Environment name for naming resources"
  type        = string
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet where the virtual machines will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group where the virtual machines will be created"
  type        = string
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the virtual machine"
  type        = string
}

variable "admin_password" {
  description = "Admin password for the virtual machine"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default     = {}
}

variable "publisher" {
  description = "Publisher of the source image"
  type        = string
  default     = "Canonical"
}

variable "offer" {
  description = "Offer of the source image"
  type        = string
  default     = "UbuntuServer"
}

variable "sku" {
  description = "SKU of the source image"
  type        = string
  default     = "24_04-lts-gen2"
}

variable "version" {
  description = "Version of the source image"
  type        = string
  default     = "latest"
}