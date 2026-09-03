# Security Group for EKS Cluster
resource "aws_security_group" "eks_cluster" {
  name_prefix = "eks-cluster-"
  vpc_id      = aws_vpc.main.id
  description = "Security group for EKS cluster"

  tags = {
    Name = "${var.project_name}-eks-cluster-sg"
  }
}

# Allow outbound traffic
resource "aws_vpc_security_group_egress_rule" "eks_cluster_egress" {
  security_group_id = aws_security_group.eks_cluster.id
  description       = "Allow all outbound traffic"
  from_port         = 0
  to_port           = 0
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

# Allow cluster communication
resource "aws_vpc_security_group_ingress_rule" "eks_cluster_from_nodes" {
  security_group_id = aws_security_group.eks_cluster.id
  description       = "Allow nodes to communicate with cluster"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  referenced_security_group_id = aws_security_group.node_group.id
}

# Security Group for Node Groups
resource "aws_security_group" "node_group" {
  name_prefix = "eks-node-"
  vpc_id      = aws_vpc.main.id
  description = "Security group for EKS node groups"

  tags = {
    Name = "${var.project_name}-eks-node-sg"
  }
}

# Allow nodes to communicate with each other
resource "aws_vpc_security_group_ingress_rule" "node_group_self" {
  security_group_id = aws_security_group.node_group.id
  description       = "Allow nodes to communicate with each other"
  from_port         = 0
  to_port           = 65535
  ip_protocol       = "tcp"
  referenced_security_group_id = aws_security_group.node_group.id
}

# Allow nodes to communicate with cluster
resource "aws_vpc_security_group_ingress_rule" "node_group_from_cluster" {
  security_group_id = aws_security_group.node_group.id
  description       = "Allow cluster to communicate with nodes"
  from_port         = 1025
  to_port           = 65535
  ip_protocol       = "tcp"
  referenced_security_group_id = aws_security_group.eks_cluster.id
}

# Allow kubelet API communication
resource "aws_vpc_security_group_ingress_rule" "node_group_kubelet" {
  security_group_id = aws_security_group.node_group.id
  description       = "Allow kubelet API communication"
  from_port         = 10250
  to_port           = 10250
  ip_protocol       = "tcp"
  referenced_security_group_id = aws_security_group.eks_cluster.id
}

# Allow outbound traffic
resource "aws_vpc_security_group_egress_rule" "node_group_egress" {
  security_group_id = aws_security_group.node_group.id
  description       = "Allow all outbound traffic"
  from_port         = 0
  to_port           = 0
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}
