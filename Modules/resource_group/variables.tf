variable "count" {
  type = number
  default = 1
  description = "Number of resource group"
}

variable "application" {
  type = string
  description = "Application name"
}

variable "environment" {
  type = string
  description = "Environment name"
}

variable "location" {
  type = string
  description = "Azure location"
}

variable "tags" {
  type = map(string)
  description = "Tags for the resource group"
}