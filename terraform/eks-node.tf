resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = var.eks_node_group_role_arn
  subnet_ids      = [module.network.public_subnet_1, module.network.public_subnet_2, module.network.private_subnet_1, module.network.private_subnet_2]
  disk_size       = var.disk_size
  instance_types  = [var.instance_type]
  # ami_type        = "AL2023_x86_64_STANDARD"
  # capacity_type   = "ON_DEMAND"

  scaling_config {
    desired_size = var.desired_capacity
    min_size     = var.min_capacity
    max_size     = var.max_capacity
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_eks_cluster.eks_cluster
  ]

  # Tags para identificação
  tags = {
    Name = var.node_group_name
  }
}
