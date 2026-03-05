resource "kubernetes_secret" "cliptozip_secret" {
  metadata {
    name = "cliptozip-secret"
  }

  data = {
    SPRING_DATASOURCE_USERNAME = var.db_username
    SPRING_DATASOURCE_PASSWORD = var.db_password
    DB_HOST                     = var.db_url
    DB_NAME                     = var.db_name
    POSTGRES_USER              = var.db_username
    POSTGRES_PASSWORD          = var.db_password
    AWS_ACCESS_KEY_ID          = var.aws_access_key_id
    AWS_SECRET_ACCESS_KEY      = var.aws_secret_access_key
    AWS_REGION                 = var.aws_region
    REDIS_HOST                 = var.redis_host
    REDIS_PORT                 = var.redis_port
    CLIPTOZIP_EVENTS_URL       = var.cliptozip_events_url
    CLIPTOZIP_NOTIFICATIONS_URL = var.cliptozip_notifications_url
    CLIPTOZIP_NOTIFICATIONS_NAME = var.cliptozip_notifications_name
    S3_BUCKET_NAME             = var.s3_bucket_name
    SPRING_MAIL_USERNAME       = var.spring_mail_username
    SPRING_MAIL_PASSWORD       = var.spring_mail_password
  }
}
