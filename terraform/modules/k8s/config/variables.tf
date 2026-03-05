variable "db_name" {
  description = "Nome do banco de dados"
  type        = string
}

variable "db_username" {
  description = "Usuário do banco de dados"
  type        = string
}

variable "db_password" {
  description = "Senha do banco de dados"
  type        = string
  sensitive   = true
}

variable "db_url" {
  description = "URL do banco de dados"
  type        = string
}

variable "aws_access_key_id" {
  description = "AWS Access Key ID"
  type        = string
}

variable "aws_secret_access_key" {
  description = "AWS Secret Access Key"
  type        = string
  sensitive   = true
}

variable "aws_region" {
    description = "Região da AWS onde os recursos estão provisionados"
    type        = string
}

variable "redis_host" {
    description = "Host do Redis"
    type        = string
}

variable "redis_port" {
    description = "Porta do Redis"
    type        = string
}

variable "cliptozip_events_url" {
    description = "URL do serviço SQS de eventos"
    type        = string
}

variable "cliptozip_notifications_url" {
    description = "URL do serviço SQS de notificações"
    type        = string
}

variable "cliptozip_notifications_name" {
    description = "Nome da fila SQS de notificações"
    type        = string
}

variable "s3_bucket_name" {
    description = "Nome do bucket S3 para armazenamento de vídeos"
    type        = string
}

variable "spring_mail_username" {
    description = "Username para configuração do Spring Mail"
    type        = string
}

variable "spring_mail_password" {
    description = "Password para configuração do Spring Mail"
    type        = string
    sensitive   = true
}

