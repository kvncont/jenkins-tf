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

# variable "id" {
#     description = "Identificatoin name"
#     default = "${var.company}-${var.deparment}-${var.environment}-${var.product_service}-${var.region}"
# }
