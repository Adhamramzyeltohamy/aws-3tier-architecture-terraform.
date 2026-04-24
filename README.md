# AWS 3-Tier Architecture using Terraform

This project demonstrates a production-ready 3-tier architecture deployed on AWS using Terraform.

## Architecture Overview

The application follows a standard 3-tier architecture:

* Presentation Layer (Web Tier): React application served using Nginx
* Application Layer (App Tier): Node.js backend running on EC2 instances
* Data Layer (Database Tier): Amazon RDS (MySQL) with Multi-AZ deployment

## Infrastructure Components

* VPC with public and private subnets across multiple Availability Zones
* Internet Gateway and NAT Gateway
* External Application Load Balancer (ALB) for web traffic
* Internal Application Load Balancer for app tier communication
* Auto Scaling Groups for both Web and App tiers
* EC2 Instances for hosting frontend and backend
* Amazon RDS (MySQL) with Multi-AZ for high availability
* Security Groups for secure communication between tiers
* S3 Bucket for backups with lifecycle policies
* VPC Endpoint (Gateway) for private S3 access

## Architecture Flow

User → External ALB → Web Tier (React + Nginx) → Internal ALB → App Tier (Node.js) → RDS (MySQL)

## Technologies Used

* Terraform
* AWS (EC2, ALB, RDS, VPC, S3, Auto Scaling)
* Node.js (Backend API)
* React (Frontend)
* Nginx (Web Server)

## Deployment

1. Clone the repository:
   git clone https://github.com/your-username/aws-3tier-architecture-terraform.git

2. Initialize Terraform:
   terraform init

3. Apply the infrastructure:
   terraform apply

4. Access the application via the External ALB DNS.

## Important Note

This project provisions the complete AWS infrastructure using Terraform (VPC, ALBs, Auto Scaling, EC2, and RDS).

However, the application deployment (user_data scripts) is customizable and should be modified based on your own application requirements.

### What you need to update:

* Replace the GitHub repository URL in the user_data section with your own project repository
* Modify the startup script to match your application (Node.js, React, etc.)
* Configure environment variables such as database connection details (RDS endpoint, username, password)
* Adjust ports if your application runs on a different port

### Example:

The provided configuration uses a sample setup, but you should update:

* Application code source (GitHub repo)
* Build and run commands
* Environment configuration

In short: Terraform builds the infrastructure, but you are responsible for configuring and deploying your application inside the instances.

## Security

* Private subnets for App and Database tiers
* Security groups restricting traffic between layers
* No direct public access to backend or database

## Features

* High availability using Multi-AZ deployment
* Auto scaling for both web and application tiers
* Load balancing for traffic distribution
* Scalable and production-ready infrastructure

## Notes

* Ensure AWS credentials are configured before deployment
* Update GitHub repository URL in user_data if needed
* RDS credentials should be secured using environment variables or AWS Secrets Manager

## Author
Adham Ramzy
