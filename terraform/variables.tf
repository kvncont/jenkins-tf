# Provider vars

variable "subscription_id" {
  description = "Subscription id service principal"
  default     = ""
}

variable "client_id" {
  description = "Client id service principal"
  default     = ""
}

variable "client_secret" {
  description = "Client secret service principal"
  default     = ""
}

variable "tenant_id" {
  description = "Tenant id service principal"
  default     = ""
}

# Config vars

variable "company" {
    description = "Company name"
    default     = "MY_COMPANY"
}

variable "deparment" {
    description = "Deparment name"
    default     = "IT"
}

variable "environment" {
    description = "Environment name"
    default     = "DEV"
}

variable "product_service" {
    description = "Product o service"
    default     = "MY_APP"
}

variable "region" {
    description = "Region name"
    default     = "eastus2"
}

variable "region_description" {
  description = "region_description"
  default     = "EASTUS2"
}
