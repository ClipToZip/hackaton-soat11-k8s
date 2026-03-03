# Public Subnets
data "aws_subnet" "public_subnet_1" {
    vpc_id = data.aws_vpc.main.id
    filter {
        name   = "tag:Name"
        values = ["${var.project_name}-public-subnet-1-${var.environment}"]
    }
}

data "aws_subnet" "public_subnet_2" {
    vpc_id = data.aws_vpc.main.id
    filter {
        name   = "tag:Name"
        values = ["${var.project_name}-public-subnet-2-${var.environment}"]
    }
}

output "public_subnet_1" {
  value = data.aws_subnet.public_subnet_1.id
}

output "public_subnet_2" {
  value = data.aws_subnet.public_subnet_2.id
}

# Private Subnets
data "aws_subnet" "private_subnet_1" {
    vpc_id = data.aws_vpc.main.id
    filter {
        name   = "tag:Name"
        values = ["${var.project_name}-private-subnet-1-${var.environment}"]
    }
}

data "aws_subnet" "private_subnet_2" {
    vpc_id = data.aws_vpc.main.id
    filter {
        name   = "tag:Name"
        values = ["${var.project_name}-private-subnet-2-${var.environment}"]
    }
}

output "private_subnet_1" {
  value = data.aws_subnet.private_subnet_1.id
}

output "private_subnet_2" {
  value = data.aws_subnet.private_subnet_2.id
}