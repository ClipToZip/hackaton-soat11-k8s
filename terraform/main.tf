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
    aws_region = var.region_default
    redis_host = var.redis_host
    redis_port = var.redis_port
    cliptozip_events_url = var.cliptozip_events_url
    cliptozip_notifications_url = var.cliptozip_notifications_url
    cliptozip_notifications_name = var.cliptozip_notifications_name
    s3_bucket_name = var.s3_bucket_name
    spring_mail_username = var.spring_mail_username
    spring_mail_password = var.spring_mail_password
}

module "k8s_auth" {
    source = "./modules/k8s/auth"
    depends_on = [module.k8s_config]

    auth_image_url = var.auth_image_url
}

module "k8s_videosvc" {
    source = "./modules/k8s/videosvc"
    depends_on = [module.k8s_auth]

    videosvc_image_url = var.videosvc_image_url
}

module "k8s_videoprc" {
    source = "./modules/k8s/videoprc"
    depends_on = [module.k8s_videosvc]

    videoprc_image_url = var.videoprc_image_url
}

module "k8s_notification" {
    source = "./modules/k8s/notification"
    depends_on = [module.k8s_config]

    notification_image_url = var.notification_image_url
}