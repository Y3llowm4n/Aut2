variable "resource_group_location" {
  default     = "East Us"
  description = "Location of resource group"
}

variable "computer_name" {
  type        = string
  description = "Name for VM1"
}

variable "admin_username" {
  type        = string
  description = "Admin name for VM2"
}

variable "admin_password" {
  type        = string
  description = "Password for linux vm"
}

variable "storage_account_name" {
  type        = string
  description = "Name for storage account"
}

variable "storage_container_name" {
  type = string
  description = "Name for storage container"
}