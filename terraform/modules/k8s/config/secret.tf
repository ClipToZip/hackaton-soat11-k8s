resource "kubernetes_secret" "cliptozip_secret" {
  metadata {
    name = "cliptozip-secret"
  }

  data = {
    SPRING_DATASOURCE_USERNAME = var.db_username # RDS: Must be decoded  /  LOCAL: Must be encoded
    SPRING_DATASOURCE_PASSWORD = var.db_password
    POSTGRES_USER              = var.db_username # RDS: Must be decoded  /  LOCAL: Must be encoded
    POSTGRES_PASSWORD          = var.db_password
    AWS_ACCESS_KEY_ID          = var.aws_access_key_id
    AWS_SECRET_ACCESS_KEY      = var.aws_secret_access_key
    REDIS_HOST                 = var.redis_host
    REDIS_PORT                 = var.redis_port
  }
}
