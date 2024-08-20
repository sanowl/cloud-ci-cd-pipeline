# Cloud CI/CD Pipeline

This project demonstrates how to set up a CI/CD pipeline using Jenkins, AWS CodeDeploy, and Terraform for infrastructure management.

## Directory Structure

- **Jenkinsfile**: Defines the CI/CD pipeline.
- **src/**: Contains the source code and tests for the application.
- **requirements.txt**: Lists Python dependencies.
- **Dockerfile**: Docker configuration for containerizing the application.
- **scripts/**: Deployment scripts for AWS.
- **terraform/**: Infrastructure as Code configuration using Terraform.

## Setup Instructions

1. Set up Jenkins on an AWS EC2 instance.
2. Use the `Jenkinsfile` to configure the CI/CD pipeline.
3. Deploy the application using the `deploy.sh` script.
4. Manage infrastructure using the Terraform scripts.
