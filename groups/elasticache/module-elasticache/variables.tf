# Tags
variable "environment" {
  type    = string
  description = "The name of the environment for tagging"
}
variable "service" {
  type    = string
  description = "The name of the service for tagging"
}

# Networks
variable "vpc_id" {
  type    = string
  description = "The ID of the data VPC"
}

variable "data_subnet_ids" {
  type    = list(string)
  description = "The subnet IDs of the data VPC"
}

variable "application_subnet_cidrs" {
  type    = list(string)
  description = "The subnet IDs for the application VPC"
}

# Elasticache
variable "node_type" {
  type = string
}

variable "node_count" {
  type = number
}

variable "engine_version" {
  type = string
}
