# DEMO 0 - Use kubectl with MicroK8s
# 
#   1- Get microK8s configuration
#   2- Grab MicroK8s token
#   3- Grab MicroK8s server IP
#   4- Use token as variable
#   5- Set MicroK8s cluster context in kubectl (No certificate)
#   6- Set MicroK8s cluster credentials in kubectl using token
#   7- Set microk8s context in kubectl
#   8- Use microk8s context in kubectl
#   9- Test a few commands
# -----------------------------------------------------------------------------
# Reference:
#   https://ubuntu.com/tutorials/install-a-local-kubernetes-with-microk8s#1-overview
#   https://microk8s.io/docs/working-with-kubectl

# 1- Get microK8s configuration
microk8s config

# 2- Grab MicroK8s token
microk8s config | grep token

# 3- Grab MicroK8s server IP
microk8s config | grep server

# 4- Use token as variable
export mk8s_token=dVhpSUE4UndXRHNkckhkUExST09lVVl2Qkx0WU50Rk9yZXRmMDNEdy96WT0K

# 5- Set MicroK8s cluster context in kubectl (No certificate)
kubectl config set-cluster microk8s --server=https://192.168.64.2:16443 --insecure-skip-tls-verify=true

# 6- Set MicroK8s cluster credentials in kubectl using token
kubectl config set-credentials microk8s-admin --token=$mk8s_token

# 7- Set microk8s context in kubectl
kubectl config set-context microk8s --cluster=microk8s --namespace=default --user=microk8s-admin

# 8- Use microk8s context in kubectl
kubectl config use-context microk8s

# 9- Test a few commands
# Get cluster info (MicroK8s)
kubectl cluster-info

# Get MicroK8s nodes
kubectl get nodes

# Get MicroK8s pods (all namespaces)
kubectl get pods --all-namespaces