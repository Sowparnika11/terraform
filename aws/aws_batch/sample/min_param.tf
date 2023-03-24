module "batch_creation" {
    source               = "./code"
    location  = "eu-west-2"
    vpc_id = "vpc-09a8c77ae21f28516"
    subnet_id  = "subnet-073f346b28ccddaf6"
}