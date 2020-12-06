# Demo 02 - Azure Kubernetes Services (AKS) deployment
#   Kubernetes cluster creation in AKS
#
#   1- Get Kubernetes version by location
#   2- Create AKS cluster
#   3- Enable Virtual kubelet addon (Optional)
#   4- Get AKS credentials for AKS cluster
#   5- Check kubectl cluster context
#   6- Get AKS cluster nodes
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
    --node-count 2 \
    --node-vm-size $vm_size \
    --node-osdisk-size 100 \
    --vm-set-type AvailabilitySet \
    --dns-name-prefix $aks_cluster-dns \
    --load-balancer-sku standard \
    --generate-ssh-keys

# 3- Enable Virtual kubelet addon (Optional)
az aks enable-addons \
    --resource-group $resource_group \
    --name $aks_cluster \
    --addons virtual-node

# 4- Get AKS credentials for AKS cluster
az aks get-credentials -a --resource-group $resource_group --name $aks_cluster

# 5- Check kubectl cluster context
kubectl config get-contexts

# 6- Get AKS cluster nodes
kubectl get nodes