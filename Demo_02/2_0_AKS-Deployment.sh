# Demo 02 - Azure Kubernetes Services (AKS) deployment
#   Kubernetes cluster creation in AKS
#
#   1- Get Kubernetes version by location
#   2- Create AKS cluster
#   3- Get AKS credentials for AKS cluster
#   4- Check kubectl cluster context
#   5- Get AKS cluster nodes
#   6- Label nodes for SQL Server and burstable workloads
#   7- Get SQL Server possible nodes
#   8- Get virtual kubelet nodes
# -----------------------------------------------------------------------------
# References:
#   Deploy an Azure Kubernetes Service cluster using the Azure CLI
#   https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough
#
#   Azure CLI - Kubernetes
#   https://docs.microsoft.com/en-us/cli/azure/aks?view=azure-cli-latest
#

# 0- Env variables | demo path
resource_group=ubuntu-masters;
aks_cluster=endurance
location=westus
k8s_version=1.19.3
vm_size=Standard_DS3_v2;

# 1- Get Kubernetes version by location
az aks get-versions --location $location --output table;

# 2- Create AKS cluster
# Two Nodes - Ubuntu VMs
az aks create \
    --resource-group $resource_group \
    --location $location \
    --name $aks_cluster \
    --kubernetes-version $k8s_version \
    --node-count 3 \
    --node-vm-size $vm_size \
    --node-osdisk-size 100 \
    --vm-set-type AvailabilitySet \
    --dns-name-prefix $aks_cluster-dns \
    --load-balancer-sku standard \
    --generate-ssh-keys

# 3- Get AKS credentials for AKS cluster
az aks get-credentials -a --resource-group $resource_group --name $aks_cluster

# 4- Check kubectl cluster context
kubectl config get-contexts

# 5- Get AKS cluster nodes
kubectl get nodes

# 6- Label nodes for SQL Server and burstable workloads
kubectl label nodes aks-agentpool-24128216-0 workload=tools
kubectl label nodes aks-agentpool-24128216-1 workload=sqlserver
kubectl label nodes aks-agentpool-24128216-2 workload=sqlserver
kubectl label nodes virtual-node-aci-linux workload=burstable

# 7- Get SQL Server possible nodes
kubectl get nodes -l workload=sqlserver

# 8- Get virtual kubelet nodes
kubectl get nodes -l workload=burstable