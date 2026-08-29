# Challenges Faced and Resolutions

## 1. Terraform State Management

**Challenge:**  
Managing Terraform state securely and preventing state files from being committed to GitHub.

**Resolution:**  
Configured Terraform state management and added Terraform state files and `.terraform` directories to `.gitignore`.

## 2. Application Deployment

**Challenge:**  
Deploying the Flask application as a containerized workload.

**Resolution:**  
Created a Dockerfile and built the Flask application as a Docker image for deployment.

## 3. Network Security

**Challenge:**  
Preventing direct public access to private application and database resources.

**Resolution:**  
Used public subnets for the load balancer and private subnets for application/database resources with security groups controlling traffic.

## 4. Database Security

**Challenge:**  
Protecting the PostgreSQL database from direct Internet access.

**Resolution:**  
Deployed RDS PostgreSQL in private subnets and restricted database access using security group rules.

## 5. Secret Management

**Challenge:**  
Avoiding hard-coded database credentials in Terraform configuration.

**Resolution:**  
Used AWS Secrets Manager for sensitive database credentials.

## 6. Monitoring

**Challenge:**  
Monitoring infrastructure and application health.

**Resolution:**  
Configured CloudWatch monitoring, logs, metrics, and dashboards.

## 7. Cost Optimization

**Challenge:**  
Avoiding unnecessary AWS costs during development.

**Resolution:**  
Used appropriately sized resources, configured log retention, and planned resource cleanup after testing.