# Demo 01 - SQL Server Kubernetes deployment (MicroK8s)
#
#   1- SQL Server Kubernetes deployment (MicroK8s)
#   2- Check Kubernetes objects
#   3- Check SQL Server pod logs
#   4- Connect to SQL Server locally
#   5- Perform database deployment (database, tables, data)
#   6- Verify Planet Earth database
# -----------------------------------------------------------------------------
# References
#   Kubernetes cheat sheet
#   https://kubernetes.io/docs/reference/kubectl/cheatsheet/
#
#   Deploy a SQL Server container in Kubernetes
#   https://docs.microsoft.com/en-us/sql/linux/tutorial-sql-server-containers-kubernetes
#   https://www.microsoft.com/en-us/sql-server/developer-get-started
#
#   Azure Data Studio
#   https://docs.microsoft.com/en-us/sql/azure-data-studio/download-azure-data-studio

# 0- Env variables | demo path
cd ~/Documents/Ubuntu-Masters/Demo_01;

# 1- SQL Server Kubernetes deployment (MicroK8s)
# Set Kubernetes context to MicroK8s
kubectl config get-contexts
kubectl config use-context microk8s

# Create dedicated namespace (optional, however is the best practice)
kubectl create namespace case-sql

# Set Kubernetes context to new namespace
kubectl config set-context --current --namespace=case-sql
kubectl config get-contexts

# Create secret for SA password
# SA password = _EnDur@nc3_
kubectl apply -f ./config-management/secret-sa-case.yaml

# Create PVC (Persistent volume claim)
kubectl apply -f ./persistent-volumes/pvc-data-case.yaml

# Create service (NodePort)
kubectl apply -f ./services/srvc-sql-case.yaml

# Create SQL Server deployment (Pod)
kubectl apply -f ./deployments/depl-sql-case.yaml --record

# 2- Check Kubernetes objects 🧐
# Set Kubernetes context to MicroK8s and case-sql namespace
kubectl config use-context microk8s
kubectl config set-context --current --namespace=case-sql
kubectl config get-contexts

# Describe password (Secret) 🔐
kubectl get secrets/sa-password-case
kubectl describe secrets/sa-password-case
# YAML file
code ./config-management/secret-sa-case.yaml

# Describe PVC (Persistent volume claim) 💾
# Storage class = microk8s-hostpath
# https://kubernetes.io/docs/concepts/storage/storage-classes/
kubectl get pvc/pvc-data-case
kubectl describe pvc/pvc-data-case

# YAML file
code ./persistent-volumes/pvc-data-case.yaml

# Describe service (NodePort) 
kubectl get service/srvc-sql-case
kubectl describe service/srvc-sql-case
# YAML file
code ./services/srvc-sql-case.yaml

# Describe SQL Server deployment (Pod)
kubectl get deployments
kubectl describe deployments/depl-sql-case

# ProTip: Limit your pods resource utilization 👀 🧐
# SQL Server - System requirements for Linux:
# Memory        2 GB
# CPUs          2 cores
# Disk space    6 GB

# SQL Server 2019 Cumulative update 6 - Ubuntu 18.04
# 2 GBs of memory out of 4 GBs available in MicroK8s

# YAML file
code ./deployments/depl-sql-case.yaml --record

# 3- Check SQL Server pod logs
# Get existing Pods in Kubernetes cluster
kubectl get pods

# Get SQL Server Pod
sql_pod=`kubectl get pods | grep sql-case | awk {'print $1'}`
echo $sql_pod

# Get SQL Server container name
kubectl get pods $sql_pod -o jsonpath='{.spec.containers[*].name}'

# Describe SQL Server pod and check logs
kubectl describe pods $sql_pod
kubectl logs $sql_pod -f

# 4- Connect to SQL Server locally
# Forward SQL Server listening port to localhost
kubectl port-forward pod/$sql_pod 1401:1433

# --------------------------------------
# Azure Data Studio steps
# --------------------------------------
# 5- Perform database deployment (database, tables, data)
# 6- Verify Planet Earth database