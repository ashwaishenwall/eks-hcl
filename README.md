# Terraform EKS Configuration

Complete Terraform configuration for AWS EKS with custom VPC and 2 worker nodes.

## Files Created

- **provider.tf** - AWS provider configuration
- **vpc.tf** - VPC, subnets, NAT gateways, and routing
- **security_groups.tf** - Security groups for cluster and nodes
- **iam.tf** - IAM roles and policies
- **eks.tf** - EKS cluster and node group
- **variables.tf** - Input variables
- **terraform.tfvars** - Default variable values
- **outputs.tf** - Output values

## Quick Start

### 1. Initialize Terraform
```bash
terraform init
```

### 2. Plan the deployment
```bash
terraform plan
```

### 3. Apply the configuration
```bash
terraform apply
```

### 4. Configure kubectl
```bash
aws eks update-kubeconfig --region us-east-1 --name my-eks-cluster
```

### 5. Verify the cluster
```bash
kubectl get nodes
```

## Configuration Details

- **Region**: us-east-1 (configurable)
- **Kubernetes Version**: 1.29
- **Worker Nodes**: 2 (t3.medium instances)
- **VPC CIDR**: 10.0.0.0/16
- **Public Subnets**: 2 (10.0.1.0/24, 10.0.2.0/24)
- **Private Subnets**: 2 (10.0.11.0/24, 10.0.12.0/24)

## Customization

Edit `terraform.tfvars` to modify:
- AWS region
- Cluster name
- Number of nodes
- Instance type
- Disk size
- VPC CIDR range

## Cleanup

Destroy all resources:
```bash
terraform destroy
```

## Important Notes

- Ensure AWS credentials are configured (`aws configure`)
- This creates resources that incur AWS charges
- NAT gateways and Load Balancers are billable resources
- Review cost estimates before applying
