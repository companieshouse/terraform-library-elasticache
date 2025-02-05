locals {
  multi_az_enabled = var.multi_az_enabled && var.cache_node_count > 1 ? true : false
}
