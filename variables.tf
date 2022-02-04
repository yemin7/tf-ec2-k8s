variable "region" {
  type        = string
  description = "Region"
}

variable "az_value" {
  type        = list(string)
  description = "Availability Zone"
}

variable "key_name" {
  type        = string
  description = "AWS KeyPair"
  sensitive   = true
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Public Subnet IDs"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private Subnet IDs"
}

variable "spot_instance" {
  type = object({
    ami                  = string
    spot_price           = string
    instance_type        = string
    spot_type            = string
    wait_for_fulfillment = bool
    internal             = bool
    num_of_instance      = number
  })
}

variable "target_group" {
  type = object({
    port        = number
    protocol    = string
    target_type = string
    health_check = object({
      path     = string
      protocol = string
      port     = number
    })
  })
  default = {
    health_check = {
      path     = "/"
      port     = 80
      protocol = "HTTP"
    }
    port        = 80
    protocol    = "HTTP"
    target_type = "instance"
  }
}
