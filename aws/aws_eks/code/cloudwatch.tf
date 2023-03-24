resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  count = var.cluster_log_types == null ? 0 : 1
  name  = "/aws/eks/${var.eks_cluster_name}/cluster"
  kms_key_id = aws_kms_key.eks_kms_key.arn
  retention_in_days = var.log_retention_in_days
  tags = merge(
    var.tags,
    {
    cloudwatch_log_group_name = "${var.eks_cluster_name}-eks-cluster-cloudwatch"
    associated_cluster        = "${var.eks_cluster_name}"
    }
  )
}
