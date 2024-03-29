# Demo 0 - Use kubectl with MicroK8s
# 
#   1- Get microK8s configuration
#   2- Grab MicroK8s admin's token (into variable)
#   3- Grab MicroK8s server IP
#   4- Set MicroK8s cluster context in kubectl (No certificate)
#   5- Set MicroK8s cluster credentials in kubectl using token
#   6- Set microk8s context in kubectl
#   7- Use microk8s context in kubectl
#   8- Use kubectl basic commands
# -----------------------------------------------------------------------------
# Reference:
#   https://ubuntu.com/tutorials/install-a-local-kubernetes-with-microk8s#1-overview
#   https://microk8s.io/docs/working-with-kubectl

# 1- Get microK8s configuration
microk8s config

# 2- Grab MicroK8s admin's token (into variable)
mk8s_token=`microk8s config | grep token | awk '{ print $2}'`

# 3- Grab MicroK8s server IP
microk8s config | grep server

# 4- Set MicroK8s cluster context in kubectl (No certificate)
kubectl config set-cluster microk8s --server=https://192.168.64.2:16443 --insecure-skip-tls-verify=true

# 5- Set MicroK8s cluster credentials in kubectl using token
kubectl config set-credentials microk8s-admin --token=$mk8s_token

# 6- Set microk8s context in kubectl
kubectl config set-context microk8s --cluster=microk8s --namespace=default --user=microk8s-admin

# 7- Use microk8s context in kubectl
kubectl config use-context microk8s

# 8- Use kubectl basic commands
# Get cluster info (MicroK8s)
kubectl cluster-info

# Get MicroK8s nodes
kubectl get nodes

# Get MicroK8s pods (all namespaces)
kubectl get pods --all-namespaces