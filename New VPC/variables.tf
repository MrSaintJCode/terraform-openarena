# Global Information
variable "region" {
  type    = string
  default = "us-east-1"
}

# VPC
# <-- VPC Subnet(s) -->
variable "vpc_range" {
  type = string
}

# <-- Public Subnet(s) -->
variable "public_subnet_1a" {
  type = string
}

variable "public_subnet_1b" {
  type = string
}

# <-- Private Subnet(s) -->
variable "private_subnet_1a" {
  type = string
}

variable "private_subnet_1b" {
  type = string
}