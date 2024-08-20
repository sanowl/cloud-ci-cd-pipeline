variable "aws_region" {
  description = "The AWS region to create resources in"
  default     = "us-west-2"
}

variable "ecr_repo_name" {
  description = "Name of the ECR repository"
  default     = "my-app-repo"
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  default     = "my-app-cluster"
}

variable "jenkins_ami" {
  description = "AMI for Jenkins EC2 instance"
  default     = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI in us-west-2, please change as needed
}

variable "jenkins_instance_type" {
  description = "Instance type for Jenkins"
  default     = "t2.micro"
}