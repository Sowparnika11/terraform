resource "aws_security_group" "create_sg" {
  count       = var.create_sg ? 1: 0
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  ingress {
    description      = var.ingress_description
    from_port        = var.ingress_from
    to_port          = var.ingress_to
    protocol         = var.ingress_protocol
    cidr_blocks      = var.vpc_cidr
    ipv6_cidr_blocks = var.ipv6_cidr
  }

  egress {
    from_port        = var.egress_from
    to_port          = var.egress_to
    protocol         = var.egress_protocol
    cidr_blocks      = var.egress_cidr
    ipv6_cidr_blocks = var.egress_ipv6_cidr
  }

  tags = var.tags
}