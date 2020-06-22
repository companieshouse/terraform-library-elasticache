
variable "environment" {
  type    = "string"
  description = "The name of the environment for tagging"
}
variable "service" {
  type    = "string"
  description = "The name of the service for tagging"
}

# Networks
variable "vpc_id" {
  type    = "string"
  description = "The ID of the VPC to create the cluster in"
}

variable "subnet_ids" {
  type    = "string"
  description = "The subnet IDs to create the subnet group in"
}

variable "ingress_subnet_cidrs" {
  type    = "string"
  description = "The subnet IDs for the VPC to allow ingress from"
}

# Elasticache
variable "provision_elasticache" {
  type = "string"
  default = "true"
}

variable "cache_node_type" {
  type = "string"
}

variable "cache_node_count" {
  type = "string"
}

variable "cache_engine_version" {
  type = "string"
}
