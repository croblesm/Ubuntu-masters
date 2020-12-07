# Demo 02 - SQL Server Kubernetes deployment (Azure Kubernetes Services)
#
#   1- SQL Server Kubernetes deployment (AKS)
#   2- Check Kubernetes objects
#   3- Check SQL Server pod logs
# -----------------------------------------------------------------------------
# Reference:
#   Kubernetes cheat sheet
#   https://kubernetes.io/docs/reference/kubectl/cheatsheet/
#
#   Deploy a SQL Server container in Kubernetes with Azure Kubernetes Services
#   https://docs.microsoft.com/en-us/sql/linux/tutorial-sql-server-containers-kubernetes
#

# 1- SQL Server Kubernetes deployment (MicroK8s)
# Set Kubernetes context to MicroK8s
kubectl config get-contexts
kubectl config use-context endurance-admin

# Create dedicated namespace (optional, however is the best practice)
kubectl create namespace plex-sql

# Set Kubernetes context to new namespace
kubectl config set-context --current --namespace=plex-sql
kubectl config get-contexts

# Create secret for SA password
# SA password = _EnDur@nc3_
kubectl apply -f ./Manifests/secret-sa-plex.yaml

# Create PVC (Persistent volume claim)
kubectl apply -f ./Manifests/pvc-data-plex.yaml

# Create service (NodePort)
kubectl apply -f ./Manifests/srvc-sql-plex.yaml

# Create SQL Server deployment (Pod)
kubectl apply -f ./Manifests/depl-sql-plex.yaml --record

# 2- Check Kubernetes objects
# All SQL Server objects in AKS
kubectl get secrets/sa-password-plex
kubectl get pvc/pvc-data-plex
kubectl get service/srvc-sql-plex
kubectl get deployments

# 3- Check SQL Server pod logs
# Get existing Pods in Kubernetes cluster
kubectl get pods -l app=sql-plex

# Get SQL Server Pod
sql_pod=`kubectl get pods -l app=sql-plex | grep sql-plex | awk {'print $1'}`
echo $sql_pod

# Get SQL Server container name
kubectl get pods $sql_pod -o jsonpath='{.spec.containers[*].name}'

# Describe SQL Server pod and check logs
kubectl describe pods $sql_pod
kubectl logs $sql_pod -f