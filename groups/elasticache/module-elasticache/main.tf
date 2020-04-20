
resource "aws_elasticache_subnet_group" "chs-elasticache" {
  name       = "${var.service}-elasticache-subnet"
  subnet_ids = var.data_subnet_ids
}

resource "aws_elasticache_replication_group" "chs-elasticache" {
  automatic_failover_enabled    = "${var.node_count == 1 ? false : true}"
  auto_minor_version_upgrade    = true

  replication_group_id          = "${var.environment}-${var.service}-elasticache"
  replication_group_description = "Elasticache Redis cluster for CHS"

  subnet_group_name = aws_elasticache_subnet_group.chs-elasticache.name

  node_type                   = var.node_type
  number_cache_clusters       = var.node_count
  engine_version              = var.engine_version
  maintenance_window          = "sat:04:00-sat:06:00"

  security_group_ids    = [aws_security_group.chs-elasticache.id]
  port                  = 6379

  tags = {
    Name = "${var.environment}-${var.service}-elasticache"
    Environment = "${var.environment}"
    Service = "${var.service}"
  }
}
