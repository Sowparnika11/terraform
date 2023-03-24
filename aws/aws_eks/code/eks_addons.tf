resource "aws_eks_identity_provider_config" "eks_identity_provider_config" {
  count        = var.enable_oidc_openid_connect == true ? 1 : 0
  cluster_name = var.eks_cluster_name
  oidc {
    client_id                     = substr(aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer, -32, -1)
    identity_provider_config_name = "${var.eks_cluster_name}-oidc"
    issuer_url                    = "https://${aws_iam_openid_connect_provider.eks_iam_openid_connect_provider[0].url}"

  }
}

resource "aws_eks_addon" "eks_coredns" {
  count = var.enable_addon_coredns == true ? 1 : 0
  cluster_name             = aws_eks_cluster.eks_cluster.name
  resolve_conflicts        = "OVERWRITE"
  addon_name               = "coredns"
  addon_version            = null
  service_account_role_arn = aws_iam_role.eks-cluster-openid_connect[0].arn
    lifecycle {
        precondition {
      condition     = var.enable_oidc_openid_connect == true
      error_message = "need to set 'var.enable_oidc_openid_connect == true' before enable the add-ons "
    }
  }
  tags = merge(
    var.tags,
    {
      "eks_addon" = "CoreDNS"
    }
  )
}

resource "aws_eks_addon" "eks_kube_proxy" {
  count = var.enable_addon_kube_proxy == true ? 1 : 0
  cluster_name             = aws_eks_cluster.eks_cluster.name
  resolve_conflicts        = "OVERWRITE"
  addon_name               = "kube-proxy"
  addon_version            = null
  service_account_role_arn = aws_iam_role.eks-cluster-openid_connect[0].arn
    lifecycle {
        precondition {
      condition     = var.enable_oidc_openid_connect == true
      error_message = "need to set 'var.enable_oidc_openid_connect == true' before enable the add-ons "
    }
  }
  tags = merge(
    var.tags,
    {
      "eks_addon" = "kube-proxy"
    }
  )
}


resource "aws_eks_addon" "eks_ebs_csi_driver" {
  count = var.enable_addon_ebs_csi_driver == true ? 1 : 0
  cluster_name             = aws_eks_cluster.eks_cluster.name
  resolve_conflicts        = "OVERWRITE"
  addon_name               = "aws-ebs-csi-driver"
  addon_version            = null
  service_account_role_arn = aws_iam_role.eks-cluster-openid_connect[0].arn
    lifecycle {
        precondition {
      condition     = var.enable_oidc_openid_connect == true
      error_message = "need to set 'var.enable_oidc_openid_connect == true' before enable the add-ons "
    }
  }
  tags = merge(
    var.tags,
    {
      "eks_addon" = "Amazon EBS CSI Driver"
    }
  )
}

resource "aws_eks_addon" "eks_vpc_cni" {
  count = var.enable_addon_vpc_cni == true ? 1 : 0
  cluster_name             = aws_eks_cluster.eks_cluster.name
  resolve_conflicts        = "OVERWRITE"
  addon_name               = "vpc-cni"
  addon_version            = null
  service_account_role_arn = aws_iam_role.eks-cluster-openid_connect[0].arn
  lifecycle {
        precondition {
      condition     = var.enable_oidc_openid_connect == true
      error_message = "need to set 'var.enable_oidc_openid_connect == true' before enable the add-ons "
    }
  }   
  tags = merge(
    var.tags, {
      "eks_addon" = "Amazon VPC CNI"
    }
  )
}
