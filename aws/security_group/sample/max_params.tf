module "create_security_group" {
  source                    = "./code"
  location                  = "eu-west-2"
  create_sg                 = true
  name                      = "DEVOPS-MADES-EASY-SG"
  description               = "DEVOPS-MADES-EASY description"
  vpc_id                    = "vpc-09a8c77ae21f28516"
  ingress_description       = "description for ingress"
  ingress_from              = 443
  ingress_to                = 443
  ingress_protocol          = "tcp"
  vpc_cidr                  = ["10.0.0.0/16"]
  ipv6_cidr                 = []
  egress_from               = 0
  egress_to                 = 0
  egress_protocol           = -1
  egress_cidr               = ["0.0.0.0/0"]
  egress_ipv6_cidr          = ["::/0"]
  tags                      = { Name = "sample sg"}
}

