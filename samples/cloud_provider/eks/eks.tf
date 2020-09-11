provider "nirmata" {
  // Nirmata API Key. Best configured as the environment variable NIRMATA_TOKEN.
  // token = ""

  // Nirmata address. Defaults to https://nirmata.io and can be configured as the environment variable NIRMATA_URL.
  // url = ""
}

// A ClusterType contains reusable configuration to create clusters.
resource "nirmata_eks_clusterType" "eks-cluster-type" {

  // a unique name for the cluster type (e.g. eks-cluster)
  // Required
  name = "eks_us-west-2_1.16"

  // the Kubernetes version (e.g. 1.16)
  // Required
  version = "1.16"

  // the AWS cloud credentials name configured in Nirmata (e.g. aws-credentials)
  // Required
  // credentials = ""

  // the AWS region into which the cluster should be deployed
  // Required
  region = "us-west-2"

  // the AWS VPC subnet ID in which the cluster should be provisioned
  // Required
  // vpc_id= ""

  // the AWS VPC subnet ID in which the cluster should be provisioned (e.g. ["subnet-e8b1a2k1j", "subnet-ey907f5v"])
  // Required
  // subnet_id= []

  // the AWS security group for firewalling (e.g. ["sg-028208181hh110"])
  // Required
  // security_groups= []

  // the AWS cluster role ARN (e.g. "arn:aws:iam::000000007:role/sample")
  // Required
  // cluster_role_arn= ""

  // the AWS SSH key name (e.g. ssh-keys)
  // Required
  // key_name= ""

  // the AWS instance type for worker nodes (e.g. "t3.medium")
  instance_types = ["t3.medium"]

  // the worker node disk size
  // Required
  disk_size = 60

  // the AWS security group for worker node firewalling (e.g. ["sg-028208181hh110"])
  // Required
  // node_security_groups = []

  // the AWS IAM role for worker nodes (e.g. "arn:aws:iam::000000007:role/sample")
  // Required
  // node_iam_role = ""
}

// A Cluster is created using a ClusterType
resource "nirmata_ProviderManaged_cluster" "eks-cluster" {

  // a unique name for the Cluster
  // Required
  name = "eks-cluster-1"

  // the cluster type
  // Required
  type_selector = nirmata_eks_clusterType.eks-cluster-type.name

  // number of worker nodes
  // Required
  node_count = 1
}

output "cluster_type_name" {
  description = "ClusterType name"
  value       = nirmata_eks_clusterType.eks-cluster-type.name
}

output "cluster_name" {
  description = "Cluster name"
  value       = nirmata_ProviderManaged_cluster.eks-cluster.name
}
