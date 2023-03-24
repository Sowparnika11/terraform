module "eks_cluster_1" {
  source                               = "../aws/aws_eks/code"
  location                             = "eu-central-1"                                   ## Mandatory
  eks_cluster_name                     = "poc-cluster-eucent1-01"                         ## Mandatory
  subnet_ids                           = ["subnet-xxxxx", "subnet-xxxxx", "subnet-xxxxx"] ## Mandatory
  cluster_log_types                    = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  eks_cluster_version                  = 1.24            ## Optional
  cluster_endpoint_private_access      = true            ## Optional 
  cluster_endpoint_public_access       = true            ## Optional
  cluster_endpoint_public_access_cidrs = null            ## Optional 
  service_ipv4_cidr                    = "172.30.0.0/16" ## Optional 
  log_retention_in_days                = 14              ## Optional
  ##Node Group
  node_desired_size    = 1             ## Optional 
  node_max_size        = 4             ## Optional 
  node_min_size        = 1             ## Optional  
  node_instance_types  = ["t2.medium"] ## Optional   
  node_disk_size       = 50            ## Optional  
  node_ami_type        = "AL2_x86_64"  ## Optional   
  node_max_unavailable = 1             ## Optional  
  node_capacity_type   = "ON_DEMAND"   ## Optional   
  tags = {                             ## Optional
    "Created by " = "Abhilash"         ## Optional
    "Env"         = "POC"              ## Optional
  }
  enable_oidc_openid_connect   = true
  enable_addon_coredns         = true
  coredns_addon_version        = null
  enable_addon_kube_proxy      = true
  kube_proxy_addon_version     = null
  enable_addon_ebs_csi_driver  = true
  ebs_csi_driver_addon_version = null
  enable_addon_vpc_cni         = true
  vpc_cni_addon_version        = null

  create_cluster_autoscaler = true
  create_metrics_server     = true
}
