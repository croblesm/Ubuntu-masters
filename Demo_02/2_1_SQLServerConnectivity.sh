# Demo 03 - SQL Server connectivity - AKS
# 
#   1- Review Kubernetes manifests
#   9- Push changes to repository
#   10- Monitor Azure pipeline
#   11- Check Flyway migration job status
#   12- Review Flyway schema history
#   13- Review changes in SQL Server GeoKids database
#   14- Check GeoKids website
#   15- Create Kubernetes and GitHub release tag
#   16- Check pipeline CI options
# -----------------------------------------------------------------------------
# References:
#   SQLCMD with Alpine
#   https://github.com/dbamaster/mssql-tools-alpine
#   
#   Virtual Kubelet
#   https://github.com/virtual-kubelet/virtual-kubelet

# 0- Env variables | demo path
cd ~/Documents/Ubuntu-Masters/Demo_03;
sa_password="_EnDur@nc3_";
az aks get-credentials --resource-group ubuntu-masters --name Endurance

# 1- Kubernetes architecture and objects
# Kubernetes cluster (1.18 version)
# Get Kubernetes context from local kubectl
kubectl config get-contexts

# Set Kubernetes context to AKS cluster (endurance)
kubectl config use-context endurance
kubectl config set-context --current --namespace=plex-sql
kubectl get nodes
# Virtual Kubelet = AKS cluster virtual node (ACI) 👌👌

# Kubernetes deployments
kubectl get deployments

# Kubernetes pods
# Get the list of pods including node name (SQL Server runs on 01 node)
kubectl get pod -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName

# Kubernetes services
kubectl get services
# NodePort for SQL Server --> No inbound connectivity outside Kubernetes cluster, port 1401
# LoadBalance for WebApp --> Inbound connectivity from internet, port 8083

# 3- Connect to SQL Server Planet Earth database
# mssql-tools-alpine: Minimalistic SQLCMD container image (~17 MBs) 👀 👍
# It provides portability and agility to run queries using a SQLCMD container on the fly.
# https://github.com/dbamaster/mssql-tools-alpine 

# Using SQLCMD container as bastion - Kubernetes pod
########################################################################################################
# sqlcmd-pod lives to fulfill its destiny: Execute queries and then, die 😅
# SQLCMD is your friend 😎 !! 

# Get all databases
# Kubernetes pod "sqlcmd-pod" scheduled on node 01, if true all resources will be deleted
# ProTip: Simple and clean list, just removing column header 👀 
#--overrides='{"spec": { "nodeSelector": {"nodename": "eks-prod-4"}}}' \
  type: virtual-kubelet
kubectl run sqlcmd-pod -i --tty --rm --restart=Never \
    --overrides='{"spec": { "nodeSelector": {"kubernetes.io/hostname": "aks-nodepool1-35295523-0"}}}' \
    --image=crobles10/mssql-tools-alpine:1.0 \
    -- sqlcmd -S srvc-sql-plex,1401 -U SA -P $sa_password -d master -h -1 \
     -Q "SET NOCOUNT ON; SELECT name from sys.databases;"

# Get all tables on GeoKids database - Formatted output
# Kubernetes pod "sqlcmd-pod" created on node 01, if true all resources will be deleted
# ProTip: Limiting the number of characters by column produces a clean output format 👌
kubectl run sqlcmd-pod -i --tty --rm --restart=Never \
    --overrides='{"spec": { "nodeSelector": {"kubernetes.io/hostname": "aks-nodepool1-35295523-0"}}}' \
    --image=crobles10/mssql-tools-alpine:1.0 \
    -- sqlcmd -S srvc-sql-plex,1401 -U SA -P $sa_password -d PlanetEarth \
     -Q "SET NOCOUNT ON; \
        SELECT  
            CONVERT(VARCHAR(32),TABLE_SCHEMA) as TABLE_SCHEMA,
            CONVERT(VARCHAR(32),TABLE_NAME) as TABLE_NAME
        FROM INFORMATION_SCHEMA.TABLES;"

# Using SQLCMD from local machine - Kubernetes port forwarding
########################################################################################################
# Getting SQL Server instance pod name
# Get cluster pod with "geokids-db" label, simple and clean list removing headers
sql_pod=`kubectl get pods -l app=sql-case --no-headers -o custom-columns=":metadata.name"`

# Local machine port 1402 mapped to 1433 of Kubernetes SQL Server pod
kubectl port-forward pod/$sql_pod 1402:1433

# SA user and password as environment variable
# The SQLCMDPASSWORD environment variable lets you set a default password for the current session.
# The SQLCMDUSER environment variable lets you set a default user for the current session.
SQLCMDPASSWORD='_EnDur@nc3_';
SQLCMDUSER='sa';

# 13- Review changes in SQL Server GeoKids database
# Get all tables on Planet Earth database - Formatted output
# ProTip: Limiting the number of characters by column produces a clean output format 👌
sqlcmd -S 127.0.0.1,1402 -d PlanetEarth -e -i ./PlatEarth-GetTables.sql