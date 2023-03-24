module "create_vpc" {
    source        = "./code"
    location      = "eu-west-2"
    is_vpc         = true
    name_prefix = "sample"
    cidr        = "10.20.0.0/16"
    prv_cidr_block_subnet = ["10.20.1.0/24","10.20.2.0/24"]
    pub_cidr_block_subnet = ["10.20.3.0/24","10.20.4.0/24"]
    az_subnet = ["eu-west-2a","eu-west-2b"]
    vpc_tag = {
        "Name"  = "owner name"
    }
}

