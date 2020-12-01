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

# 1- Create namespace, secret, pvc, service and SQL Server deployment
# Create dedicated namespace
kubectl create namespace case-sql

# Set Kubernetes context to new namespace
kubectl config set-context --current --namespace=case-sql
kubectl config get-contexts

# Create secret for SA password
# SA password = _EnDur@nc3_
kubectl apply -f ./config-management/secret-sa-case.yaml

# Describe password (Secret) 🔐
kubectl get secrets/sa-password-case
kubectl describe secrets/sa-password-case
kubectl get secrets/sa-password-case -o json

# Create PVC
kubectl apply -f ./persistent-volumes/pvc-data-case.yaml
kubectl get pvc/pvc-data-case
# Storage class = microk8s-hostpath

kubectl describe pvc/pvc-data-case

# Create service (Load balancer)
kubectl apply -f ./services/srvc-sql-case.yaml

# Create SQL Server deployment (Pod)
kubectl apply -f ./deployments/depl-sql-case.yaml --record

# 2- Check namespace, secret, pvc, service and pod
# Checking all resources on case-sql namespace
kubectl get pvc
kubectl get services
kubectl get pods
pod=`kubectl get pods | grep mssql-case-deployment | awk {'print $1'}`
kubectl describe pods $pod

# 3- Check pod logs
kubectl logs $pod -f

# Check pod from Docker CLI
docker stats --all --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}"