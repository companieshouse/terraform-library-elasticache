# Region
variable "region" {
  type = string
}

# Tags
variable "environment" {
  type    = string
  description = "The name of the environment for tagging"
}
variable "service" {
  type    = string
  description = "The name of the service for tagging"
  default = "chs"
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
