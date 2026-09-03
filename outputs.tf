output "cluster_name" {
  value       = aws_eks_cluster.main.name
  description = "The name of the EKS cluster"
}

output "cluster_endpoint" {
  value       = aws_eks_cluster.main.endpoint
  description = "Endpoint for your EKS Kubernetes API"
}

output "cluster_arn" {
  value       = aws_eks_cluster.main.arn
  description = "The Amazon Resource Name (ARN) of the cluster"
}

output "cluster_certificate_authority_data" {
  value       = aws_eks_cluster.main.certificate_authority[0].data
  description = "Base64 encoded certificate data required to communicate with the cluster"
  sensitive   = true
}

output "cluster_security_group_id" {
  value       = aws_security_group.eks_cluster.id
  description = "Security group ID attached to the EKS cluster"
}

output "node_group_id" {
  value       = aws_eks_node_group.main.id
  description = "EKS node group ID"
}

output "node_security_group_id" {
  value       = aws_security_group.node_group.id
  description = "Security group ID attached to the EKS node group"
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC ID"
}

output "private_subnet_ids" {
  value       = aws_subnet.private[*].id
  description = "Private subnet IDs"
}

output "public_subnet_ids" {
  value       = aws_subnet.public[*].id
  description = "Public subnet IDs"
}

output "configure_kubectl" {
  value       = "aws eks update-kubeconfig --region ${data.aws_availability_zones.available.names[0]} --name ${aws_eks_cluster.main.name}"
  description = "Command to configure kubectl"
}
