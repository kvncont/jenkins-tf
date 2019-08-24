# Provider vars

variable "subscription_id" {
  description = "Subscription id service principal"
  default = ""
}

variable "client_id" {
  description = "Client id service principal"
  default = ""
}

variable "client_secret" {
  description = "Client secret service principal"
  default = ""
}

variable "tenant_id" {
  description = "Tenant id service principal"
  default = ""
}

# Config vars 

variable "company" {
    description = "Company name"
    default = "BAC"
}

variable "deparment" {
    description = "Deparment name"
    default = "GSBE"
}

variable "environment" {
    description = "Environment name"
    default = "DEV"
}

variable "product_service" {
    description = "Product o service"
    default = "REPORT_SERVICE"
}

variable "region" {
    description = "Region name"
    default = "eastus2"
}
