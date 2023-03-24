module "eks" {
  source   = "../aws/aws_eks/code"
  location                             = "eu-west-2"
  eks_cluster_name                     = "sample"
  subnet_ids                           = ["subnet-xxx1", "subnet-xxx2", "subnet-xx3"]
}
