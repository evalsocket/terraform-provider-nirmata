provider "nirmata" {
  // Nirmata API Key. Best configured as the environment variable NIRMATA_TOKEN.
  // token = ""

  // Nirmata address. Defaults to https://nirmata.io and can be configured as the environment variable NIRMATA_URL.
  // url = ""
}

// A ClusterType contains reusable configuration to create clusters.
resource "nirmata_aks_clusterType" "aks-cluster-type" {
  
  // a unique name for the cluster type (e.g. az-cluster)
  // Required
  name = "aks-tf-1"

  // the Kubernetes version (e.g. 1.17.7)
  // Required
  version = "1.17.7" 
  
  // the Azure cloud credentials name configured in Nirmata (e.g. azure-credentials)
  // Required
  // credentials = ""

  // the Azure region into which the cluster should be deployed
  // Required
  region = "centralus"

  // the Azure resource group
  // Required
  // resourcegroup = ""

  // the Azure subnet ID to use for the NodePool. The ID is a long path like this:
  // "/subscriptions/{uuid}/resourceGroups/{name}/providers/Microsoft.Network/virtualNetworks/{name}/subnets/default"
  // Required
  subnetid = "/subscriptions/baf89069-e8f3-46f8-b74e-c146931ce7a4/resourceGroups/nirmata-demo/providers/Microsoft.Network/virtualNetworks/nirmata-demo-network/subnets/default"

  // the Azure VM size to use (e.g. Standard_D2_v3)
  // Required
  vmsize = "Standard_D2_v3" 

  // the VM set type (VirtualMachineScaleSets or AvailabilitySets)
  // Required
  vmsettype = "VirtualMachineScaleSets" 
  
  // the worker node disk size in GB
  // Required
  disksize = 60

  // enable HTTPS Application Routing
  // Optional
  httpsapplicationrouting= false

  // enable container monitoring
  // Optional
  monitoring= false

  // the workspace ID to store monitoring data
  // Optional
  workspaceid = ""
}

// A Cluster is created using a ClusterType
resource "nirmata_ProviderManaged_cluster" "aks-cluster" {

  // a unique name for the Cluster
  // Required
  name       = "tf-akscluster"

  // the cluster type
  // Required
  type_selector  =  nirmata_aks_clusterType.aks-cluster-type.name

  // number of worker nodes
  // Required
  node_count = 1
}

output "cluster_type_name" {
  description = "ClusterType name"
  value       = nirmata_aks_clusterType.aks-cluster-type.name
}

output "cluster_name" {
  description = "Cluster name"
  value       = nirmata_ProviderManaged_cluster.aks-cluster.name
}

