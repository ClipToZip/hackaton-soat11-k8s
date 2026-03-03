module "network" {
    source = "./modules/network"

    project_name = var.project_name
    environment  = var.environment
}

module "k8s_config" {
    source = "./modules/k8s/config"
    depends_on = [aws_eks_node_group.eks_node_group]

    db_name = var.db_name
    db_username = var.db_username
    db_password = var.db_password
    db_url = var.db_url
    aws_access_key_id = var.aws_access_key_id
    aws_secret_access_key = var.aws_secret_access_key
    redis_host = var.redis_host
    redis_port = var.redis_port
}

module "k8s_auth" {
    source = "./modules/k8s/auth"
    depends_on = [module.k8s_config]

    auth_image_url = var.auth_image_url
}