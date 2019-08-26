# terraform {
#   backend "azurerm" {
#     resource_group_name  = "RG"
#     storage_account_name = "SA"
#     container_name       = "SC"
#     key                  = "dev.terraform.tfstate"
#   }
# }

provider "azurerm" {
    version = "~> 1.31"

    subscription_id = "${var.subscription_id}"
    client_id       = "${var.client_id}"
    client_secret   = "${var.client_secret}"
    tenant_id       = "${var.tenant_id}"
}

resource "azurerm_resource_group" "resource_group" {
    name     = "RG-${var.company}-${var.deparment}-${var.environment}-${var.product_service}-${var.region}"
    location = "${var.region}"
}

# resource "azurerm_storage_account" "storage_account" {
#   name                     = "SA-${var.company}-${var.deparment}-${var.environment}-${var.product_service}-${var.region}"
#   resource_group_name      = "${azurerm_resource_group.resource_group.name}"
#   location                 = "${var.region}"
#   account_tier             = "Standard"
#   account_replication_type = "LRS"

#   tags = {
#     environment = "${var.environment}"
#   }
# }

# resource "azurerm_storage_container" "storage_container" {
#   name                  = "SC-tfstate-${var.company}-${var.deparment}-${var.environment}-${var.product_service}-${var.region}"
#   storage_account_name  = "${azurerm_storage_account.storage_account.name}"
#   container_access_type = "private"
# }
