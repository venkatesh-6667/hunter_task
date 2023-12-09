# hunter_task

# Project Description

This project consists of several components and scripts:

## 1. Terraform

Terraform is used to provision infrastructure on AWS. It creates a VPC with public and private subnets, NAT Gateway, Internet Gateway, security groups, and two EC2 instances.

### Launch Instructions

Ensure you have Terraform installed and configured with AWS credentials. Update the provider block in the `main.tf` file with your own AWS credentials. Then, run the following commands:

```bash
terraform init
terraform plan
terraform apply

2. Bash Script
This Bash script identifies prime numbers within a specified range.

Execution Instructions
To find prime numbers between a specific range, modify the start_range and end_range variables in the script and execute it:

bash prime_numbers_script.sh

note: this script prints prime numbers between 100 - 150

3. Docker file and Docker Compose File

This Dockerfile sets up a Node.js environment for a web application. It installs dependencies, exposes port 80, and runs the application.
The Docker Compose file sets up Loki, Promtail, Grafana, and a Node.js application for log aggregation and visualization.

Launch Instructions
Make sure you have Docker and Docker Compose installed. Navigate to the directory containing the Docker Compose file and execute:

docker-compose up
