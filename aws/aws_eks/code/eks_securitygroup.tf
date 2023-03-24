#-----------------------------------------------------------------
# checkov:skip=CKV2_AWS_5:Security Groups are attached to another resource
# attaching security group with ENIs or EC2 instance is not required for eks, hence skipping CKV2_AWS_5

data "aws_subnet" "eks_subnet" {
  id = var.subnet_ids[0]
}

resource "aws_security_group" "eks_cluster_securitygroup" {
  name        = "${var.eks_cluster_name}_eks_cluster_securitygroup"
  description = "Allow TLS inbound traffic"
  vpc_id      = data.aws_subnet.eks_subnet.vpc_id

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    self      = true
  }
  tags = {
    Name = "${var.eks_cluster_name}_eks_cluster_sg"
  }
    lifecycle {
    create_before_destroy = true
  }
}

