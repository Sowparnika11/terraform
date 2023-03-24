module "create_security_group" {
  source                    = "./code"
  location                  = "eu-west-2"
  create_sg                 = true
  name                      = "DEVOPS-MADES-EASY-SG"
  description               = "DEVOPS-MADES-EASY description"
  vpc_id                    = "vpc-09a8c77ae21f28516"
  tags                      = { Name = "sample sg"}
}

