# Use kubectl with microk8s
# Get microK8s configuration
microk8s config

# Set token into variable
micro_token=dVhpSUE4UndXRHNkckhkUExST09lVVl2Qkx0WU50Rk9yZXRmMDNEdy96WT0K

# With certificate
#kubectl config set-cluster microk8s --server=https://192.168.64.2:16443 --certificate-authority=/Users/carlos/.kube/myCert.crt --insecure-skip-tls-verify=true

# Without certificate
kubectl config set-cluster microk8s --server=https://192.168.64.2:16443 --insecure-skip-tls-verify=true

# Use token
kubectl config set-credentials microk8s-admin --token=$micro_token

# Set microk8s context
kubectl config set-context microk8s --cluster=microk8s --namespace=default --user=microk8s-admin

# Use microk8s context
kubectl config use-context microk8s

# Test
kubectl get nodes
kubectl get pods