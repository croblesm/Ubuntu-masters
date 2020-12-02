# DEMO 1 - SQL Server Kubernetes deployment
#
#   1- Create Kubernetes objects for SQL Server deployment
#   2- Check Kubernetes objects
#   3- Check SQL Server pod logs
#   4- Connect to SQL Server using Azure Data Studio (ADS)
#   5- Deploy a database script
#   6- Run queries
#   7- Perform SQL Server version upgrade
#   8- Deploy new database objects
# -----------------------------------------------------------------------------
# References
#   Kubernetes cheat sheet
#   https://kubernetes.io/docs/reference/kubectl/cheatsheet/
#
#   Deploy a SQL Server container in Kubernetes with Azure Kubernetes Services (AKS)
#   https://docs.microsoft.com/en-us/sql/linux/tutorial-sql-server-containers-kubernetes
#   https://www.microsoft.com/en-us/sql-server/developer-get-started
#

# 0- Env variables | demo path
cd ~/Documents/Ubuntu-Masters/Demo_01;
sa_password="_EnDur@nc3_";

# 1- Create Kubernetes objects for SQL Server deployment
# Create dedicated namespace
kubectl create namespace case-sql

# Create secret for SA password
# SA password = _EnDur@nc3_
kubectl apply -f ./config-management/secret-sa-case.yaml

# Create PVC (Persistent volume claim)
kubectl apply -f ./persistent-volumes/pvc-data-case.yaml

# Create service (Load balancer)
kubectl apply -f ./services/srvc-sql-case.yaml

# Create SQL Server deployment (Pod)
# ProTip: Limit your pods resource utilization 👀 🧐
# SQL Server - System requirements
# Memory        2 GB
# CPUs          2 cores
# Disk space    6 GB

# SQL Server 2019 CU8 - Ubuntu 18.04
# 2 GBs of memory out of 4 GBs available in MicroK8s
kubectl apply -f ./deployments/depl-sql-case.yaml --record

# 2- Check Kubernetes objects
# Set Kubernetes context to new namespace
kubectl config set-context --current --namespace=case-sql
kubectl config get-contexts

# Describe password (Secret) 🔐
kubectl get secrets/sa-password-case
kubectl describe secrets/sa-password-case
kubectl get secrets/sa-password-case -o json

# Describe PVC (Persistent volume claim)
kubectl get pvc/pvc-data-case
kubectl describe pvc/pvc-data-case
# Storage class = microk8s-hostpath
# https://kubernetes.io/docs/concepts/storage/storage-classes/

# Describe service (NodePort)
kubectl get service/srvc-sql-case
kubectl describe service/srvc-sql-case

# Create SQL Server deployment (Pod)
kubectl get deployments/deployment-sql-case
kubectl describe deployments/deployment-sql-case

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

# 4- Connect to SQL Server using Azure Data Studio (ADS)
# Forward SQL Server listening port to localhost
kubectl port-forward pod/$sql_pod 1401:1433

# --------------------------------------
# Azure Data Studio steps
# --------------------------------------
# 5- Deploy a database script
# 6- Run queries
# 7- Perform SQL Server version upgrade
# 8- Deploy new database objects