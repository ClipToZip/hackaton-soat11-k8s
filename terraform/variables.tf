variable "region_default" {
  description = "Região da AWS onde o EKS será criado"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nome do projeto"
  type        = string
  default     = "cliptozip"
}

variable "environment" {
  description = "Ambiente (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "cluster_name" {
  description = "Nome do cluster EKS"
  type        = string
  default     = "CLIPTOZIP-EKS-CLUSTER"
}

variable "node_group_name" {
  description = "Nome do Node Group"
  type        = string
  default     = "cliptozip-node-group"
}

variable "disk_size" {
  description = "Tamanho do disco EBS para as instâncias EC2 do grupo de nós"
  type        = number
  default     = 20
}

variable "instance_type" {
  description = "Tipo de instância EC2 para os nós do EKS"
  type        = string
  default     = "t3.medium"
}

variable "desired_capacity" {
  description = "Número desejado de nós"
  type        = number
  default     = 2
}

variable "max_capacity" {
  description = "Capacidade máxima de nós"
  type        = number
  default     = 3
}

variable "min_capacity" {
  description = "Capacidade mínima de nós"
  type        = number
  default     = 1
}

variable "db_name" {
  description = "Nome do banco de dados"
  type        = string
  default     = "videodb"
}

variable "db_username" {
  description = "Usuário do banco de dados"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "Senha do banco de dados"
  type        = string
  sensitive   = true
}

variable "db_url" {
  description = "URL do banco de dados"
  type        = string
  default     = "" # Substitua pelo endpoint do seu banco de dados RDS
}

variable "aws_access_key_id" {
  description = "AWS Access Key ID"
  type        = string
  sensitive   = true
}

variable "aws_secret_access_key" {
  description = "AWS Secret Access Key"
  type        = string
  sensitive   = true
}

variable "redis_host" {
  description = "Host do Redis"
  type        = string
  default     = ""
}

variable "redis_port" {
  description = "Porta do Redis"
  type        = string
  default     = "6379"
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

variable "auth_image_url" {
  description = "URL da imagem do Auth"
  type        = string
  default     = ""
}

variable "videosvc_image_url" {
  description = "URL da imagem do serviço videosvc"
  type        = string
  default     = ""
}

variable "videoprc_image_url" {
  description = "URL da imagem do serviço videoprc"
  type        = string
  default     = ""
}

variable "notification_image_url" {
  description = "URL da imagem do serviço notification"
  type        = string
  default     = ""
}

variable "eks_cluster_role_arn" {
  description = "ARN da role IAM para o EKS Cluster"
  type        = string
  default     = "arn:aws:iam::419241261789:role/poc-aws-eks-cluster-policy" # Substitua pelo ARN da sua role IAM
}

variable "eks_node_group_role_arn" {
  description = "ARN da role IAM para o EKS Node Group"
  type        = string
  default     = "arn:aws:iam::419241261789:role/poc-aws-eks-node-policy" # Substitua pelo ARN da sua role IAM
}