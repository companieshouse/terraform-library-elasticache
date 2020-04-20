
resource "aws_security_group" "chs-elasticache" {
  name        = "${var.environment} ${var.service} elasticache security group"
  vpc_id = "${var.vpc_id}"

  # Mesos Slaves
  ingress {
    from_port = 6379
    to_port   = 6379
    protocol  = "tcp"
    cidr_blocks = var.application_subnet_cidrs
  }

  # Allow prometheus server access
  ingress {
    from_port = 9100
    to_port   = 9100
    protocol  = "tcp"
    cidr_blocks = var.application_subnet_cidrs
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
