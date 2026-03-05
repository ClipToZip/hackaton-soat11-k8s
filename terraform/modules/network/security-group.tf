resource "aws_security_group" "eks_security_group" {
  name        = "${var.project_name}-eks-sg-${var.environment}"
  description = "Security group for EKS cluster"
  vpc_id      = data.aws_vpc.main.id

  # HTTP - Para aplicações
  ingress {
    description = "HTTP - Application"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS - Para aplicações
  ingress {
    description = "HTTPS - Application"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # NodePort range - Para serviços Kubernetes
  ingress {
    description = "NodePort Services"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Comunicação interna do cluster
  ingress {
    description = "EKS Cluster Communication"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    self        = true
  }

  # All outbound traffic
  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-eks-security-group"
  }
}

output "security_group_id" {
  value = aws_security_group.eks_security_group.id
}
