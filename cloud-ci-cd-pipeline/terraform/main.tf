provider "aws" {
  region = var.aws_region
}

# ECR Repository
resource "aws_ecr_repository" "app_repo" {
  name = var.ecr_repo_name
}

# ECS Cluster
resource "aws_ecs_cluster" "app_cluster" {
  name = var.ecs_cluster_name
}

# Simple EC2 Instance for Jenkins
resource "aws_instance" "jenkins" {
  ami           = var.jenkins_ami
  instance_type = var.jenkins_instance_type
  tags = {
    Name = "Jenkins-Server"
  }
}

output "jenkins_public_ip" {
  description = "Public IP of the Jenkins server"
  value       = aws_instance.jenkins.public_ip
}

output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = aws_ecr_repository.app_repo.repository_url
}