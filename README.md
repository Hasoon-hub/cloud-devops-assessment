Cloud & DevOps Engineer Assessment
Overview
This project provides a full deployment solution for a simple static web application in a cloud-based Kubernetes environment. The solution uses AWS for cloud infrastructure, Terraform for Infrastructure as Code (IaC), Docker for containerization, Kubernetes (EKS) for container orchestration, and Prometheus for monitoring the infrastructure and application.

The static web application will serve content via Nginx running inside a Docker container, deployed to an AWS EKS Kubernetes cluster.

Solution Architecture
Cloud Provider: AWS
Kubernetes Service: AWS EKS (Elastic Kubernetes Service)
Containerization: Docker
Infrastructure as Code (IaC): Terraform
Monitoring: Prometheus (installed via Helm)
Application: Simple static HTML page served by Nginx
Prerequisites
Before you start, ensure that the following tools are installed and configured:

Terraform: Install Terraform
kubectl: Install kubectl
AWS CLI: Install AWS CLI
Docker: Install Docker
Helm: Install Helm
Make sure that you have access to an AWS account with appropriate permissions to create resources like EKS clusters, VPCs, IAM roles, etc.

1. Provision Infrastructure with Terraform
This step uses Terraform to provision the necessary AWS resources for hosting the Kubernetes cluster.

Step 1: Clone the Repository
Clone the repository that contains the Terraform configuration files, Kubernetes manifests, and Dockerfile.

bash
Copy code
git clone https://github.com/your-username/cloud-devops-assessment.git
cd cloud-devops-assessment
Step 2: Initialize Terraform
Initialize Terraform to download the required providers and modules:

bash
Copy code
terraform init
Step 3: Apply Terraform Configuration
Run the terraform apply command to provision the infrastructure in AWS (EKS cluster, VPC, subnets, IAM roles, etc.).

bash
Copy code
terraform apply
Terraform will prompt for confirmation before proceeding. Type yes to confirm.
Terraform will provision the AWS resources based on the configuration.
Step 4: Configure kubectl for EKS
Once the infrastructure is provisioned, configure kubectl to interact with the newly created EKS cluster:

bash
Copy code
aws eks --region us-west-2 update-kubeconfig --name webapp-cluster
Replace us-west-2 with the region where your resources are provisioned, and webapp-cluster with the name of your EKS cluster if different.

2. Deploy the Web Application to Kubernetes
Step 1: Build and Push the Docker Image
Navigate to the folder containing the Dockerfile and the static HTML file (index.html), and build the Docker image.

bash
Copy code
docker build -t webapp .
Next, tag and push the image to your preferred container registry (e.g., Docker Hub, AWS ECR).

bash
Copy code
docker tag webapp your-dockerhub-username/webapp
docker push your-dockerhub-username/webapp
Make sure to replace your-dockerhub-username with your actual Docker Hub username or use an AWS ECR registry if preferred.

Step 2: Deploy the Application to EKS
Apply the Kubernetes manifests to deploy the web application:

bash
Copy code
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
This will create the Kubernetes deployment and expose the web app via a LoadBalancer service.

Step 3: Verify the Deployment
To check the status of the pods:

bash
Copy code
kubectl get pods
To verify that the LoadBalancer is provisioned and obtain the external IP address:

bash
Copy code
kubectl get svc webapp-service
Access the web application by navigating to the external IP address of the LoadBalancer in your browser.

3. Set Up Prometheus Monitoring
Prometheus will be used to monitor the Kubernetes cluster and the web application. The Prometheus and Grafana stack will be deployed using Helm.

Step 1: Install Prometheus via Helm
Add the Prometheus Helm repository:

bash
Copy code
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
Install Prometheus and Grafana in the Kubernetes cluster:

bash
Copy code
helm install prometheus prometheus-community/kube-prometheus-stack
Step 2: Verify Prometheus Installation
To verify that Prometheus and Grafana are running, check the pods in the monitoring namespace:

bash
Copy code
kubectl get pods -n monitoring
Prometheus will now be scraping metrics from your EKS cluster and will allow you to monitor the performance of both the infrastructure and the web application.

4. GitHub Repository Structure
Your repository should have the following structure:

graphql
Copy code
cloud-devops-assessment/
│
├── main.tf                # Terraform configuration for AWS infrastructure
├── deployment.yaml        # Kubernetes deployment manifest
├── service.yaml           # Kubernetes service manifest
├── Dockerfile             # Dockerfile for the web application
├── index.html             # Static HTML content for the web application
├── README.md              # This README file (deployment instructions)
└── terraform.tfvars        # Optional: Terraform variables for configuration
5. Additional Notes
Scaling: The application is deployed with 2 replicas by default. To scale the application, you can modify the replicas field in the deployment.yaml file and reapply it.

bash
Copy code
kubectl apply -f deployment.yaml
Customization: You can customize the static HTML content in index.html to suit your needs.

Monitoring Dashboards: Grafana dashboards can be accessed by port-forwarding to the Grafana pod:

bash
Copy code
kubectl port-forward svc/prometheus-grafana 3000:80 -n monitoring
You can access Grafana at http://localhost:3000 using the default credentials (admin/admin).

Conclusion
This guide demonstrates how to deploy a simple static web application to AWS using EKS, Terraform, Docker, and Kubernetes. The application is fully containerized, scalable, and monitored using Prometheus. By following these steps, you can deploy and manage applications in the cloud using best practices for infrastructure automation and monitoring.


End of Document
How to Share Your GitHub Repository
Once you have completed these steps and pushed your project to GitHub, you can share the link to the repository with your reviewers, collaborators, or anyone who needs access to the solution.

For example, the link to your GitHub repository might look like:

arduino
Copy code
https://github.com/your-username/cloud-devops-assessment
You can now copy this URL and share it as needed.
