#variable "eks_cluster" {}
# variable "repo_path" {}
# variable "create_cluster_autoscaler" {}
# variable "create_metrics_server" {}



provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.eks_cluster.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.certificate_authority[0].data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      # This requires the awscli to be installed locally where Terraform is executed
      args = ["eks", "get-token", "--cluster-name", var.eks_cluster_name]
    }
  }
}

resource "helm_release" "metrics_server" {
  #count           = var.create_metrics_server ? 1 : 0
  name            = "metrics-server"
  #repository      = "./helm"
  chart           = "${path.module}/helm/metrics_server"
  version         = "0.1.0"
  cleanup_on_fail = true
  replace         = true
}

resource "helm_release" "cluster_autoscaler" {
  #count           = var.create_cluster_autoscaler ? 1 : 0
  name            = "cluster-autoscaler"
  chart           = "${path.module}/helm/cluster_autoscaler"
  version         = "0.1.0"
  cleanup_on_fail = true
  replace         = true
  set {
    name  = "command.eksClusterName"
    value = var.eks_cluster_name
  }
}


