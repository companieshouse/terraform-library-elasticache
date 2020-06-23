
# # ------------------------------------------------------------------------------
# # Security Group
# # ------------------------------------------------------------------------------
resource "aws_security_group" "elasticache" {
  count = "${var.provision_elasticache ? 1 : 0}"
  name   = "${var.environment} ${var.service} elasticache security group"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 6379
    to_port   = 6379
    protocol  = "tcp"
    cidr_blocks = ["${split(",", var.ingress_subnet_cidrs)}"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-${var.service}-elasticache-security-group"
    Environment = "${var.environment}"
    Service = "${var.service}"
  }
}

# # ------------------------------------------------------------------------------
# # Elasticache
# # ------------------------------------------------------------------------------

resource "aws_elasticache_subnet_group" "elasticache" {
  count = "${var.provision_elasticache ? 1 : 0}"
  name       = "${var.environment}-${var.service}-elasticache-subnet-group"
  subnet_ids = ["${split(",", var.subnet_ids)}"]
}

resource "aws_elasticache_replication_group" "redis" {
  count = "${var.provision_elasticache ? 1 : 0}"
  automatic_failover_enabled    = "${var.cache_node_count == 1 ? false : true}"
  auto_minor_version_upgrade    = true

  replication_group_id          = "${var.environment}-${var.service}-elasticache"
  replication_group_description = "Elasticache Redis cluster"

  subnet_group_name = "${aws_elasticache_subnet_group.elasticache.name}"

  node_type              = "${var.cache_node_type}"
  number_cache_clusters  = "${var.cache_node_count}"
  engine_version         = "${var.cache_engine_version}"

  security_group_ids    = ["${aws_security_group.elasticache.id}"]
  port                  = 6379

  tags = {
    Name = "${var.environment}-${var.service}-elasticache"
    Environment = "${var.environment}"
    Service = "${var.service}"
  }
}
