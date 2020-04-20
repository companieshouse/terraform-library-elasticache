provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {}
}

module "elasticache" {
  source                    = "./module-elasticache"
  vpc_id                    = data.terraform_remote_state.ch-service-terraform-state.outputs.vpc_id
  data_subnet_ids           = split(",", data.terraform_remote_state.ch-service-terraform-state.outputs.data_ids)
  application_subnet_cidrs  = split(",", data.terraform_remote_state.ch-service-terraform-state.outputs.application_cidrs)
  environment               = var.environment
  service                   = var.service
  node_type                 = var.node_type
  node_count                = var.node_count
  engine_version            = var.engine_version
}


# # ------------------------------------------------------------------------------
# # Locals
# # ------------------------------------------------------------------------------
  locals {
    development_account = var.environment != "staging" && var.environment != "live"
  }

# # ------------------------------------------------------------------------------
# # Remote State
# # ------------------------------------------------------------------------------

data "terraform_remote_state" "ch-service-terraform-state" {
  backend = "s3"
  config = {
    bucket = "${local.development_account ? "ch-development-terraform-state-london" : "ch-service-${var.environment}-terraform-state"}"
    key    = "${local.development_account ? "env:/development/development/development.tfstate" : "env:/${var.environment}/${var.environment}/${var.environment}.tfstate"}"
    region = var.region
  }
}
