# Demo 03 - SQL Server version upgrade (Kubernetes style 😎)
# 
#   1- Connect to Kubernetes cluster in AKS
#   2- Check SQL Server version (pod image)
#   3- Check PVC - Matching AZ disk with AKS-PVC
#   4- Upgrade SQL Server (pod image)
#   5- Check rolling upgrade status
#   6- Check rollout history
#   7- Check SQL Server instance
# -----------------------------------------------------------------------------
#   Kubernetes cheat sheet:
#   https://kubernetes.io/docs/reference/kubectl/cheatsheet/

# 0- Env variables | demo path
cd ~/Documents/Ubuntu-Masters/Demo_03;
SQLCMDPASSWORD='_EnDur@nc3_';
SQLCMDUSER='sa';
az aks get-credentials --resource-group ubuntu-masters --name Endurance

# 1- Connect to Kubernetes cluster in AKS
kubectl config use-context endurance
kubectl config set-context --current --namespace=plex-sql
kubectl config get-contexts

# 2- Check SQL Server version (pod image)
kubectl get pods -l app=sql-case --all-namespaces -o jsonpath="{.items[*].spec.containers[*].image}"

# 3- Check PVC - Matching AZ disk with AKS-PVC
kubectl describe pvc pvc-data-plex

# Filter by Volume
kubectl describe pvc pvc-data-plex | grep "Volume:" #  ➡️ Match it with AKS-PVC
# Go to the portal --> All resources --> Look for PVC disk

# 4- Upgrade SQL Server (pod image)
kubectl --record deployment set image mssql-plex mssql=mcr.microsoft.com/mssql/server:2019-CU8-ubuntu-18.04

# 5- Check rolling upgrade status
# In terminal 1
kubectl rollout status -w deployment mssql-plex

# In terminal 2
kubectl get pods
NewPod=`kubectl get pods | grep mssql-plex | awk {'print $1'}`
kubectl describe pods $NewPod
kubectl logs $NewPod -f

# 6- Check rollout history
kubectl rollout history deployment mssql-deployment

# 7- Check SQL Server instance
# List databases
sqlcmd -S 127.0.0.1,1402 -d master -h -1 \
  -Q "SET NOCOUNT ON; SELECT name from sys.databases;"

# Get SQL Server version and OS details
sqlcmd -S 127.0.0.1,1402 -d master \
  -Q "SELECT \
      SERVERPROPERTY('ServerName') AS [Instance Name],
      SERVERPROPERTY('ProductVersion') AS [Product Version],
      SERVERPROPERTY('ProductUpdateLevel') AS [CU],
      RIGHT(@@version, LEN(@@version)- 3 -charindex (' ON ', @@VERSION)) [OS Version];"