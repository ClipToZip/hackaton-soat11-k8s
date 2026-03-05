resource "aws_eks_cluster" "eks_cluster" {
    name = var.cluster_name
    role_arn = var.eks_cluster_role_arn

    vpc_config {
        subnet_ids = [module.network.public_subnet_1, module.network.public_subnet_2, module.network.private_subnet_1, module.network.private_subnet_2]
        security_group_ids = [module.network.security_group_id]
    }

    access_config {
        authentication_mode = "CONFIG_MAP"
        bootstrap_cluster_creator_admin_permissions = true
    }
}