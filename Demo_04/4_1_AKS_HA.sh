# Demo 04 - SQL Server HA in Kubernetes
# 
#   1- Simulate failure
#   2- Verify SQL Server instance
#   3- Check AKS dashboard
# -----------------------------------------------------------------------------
# References
#   Pacemaker cluster for SQL Server on Linux
#   https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-deploy-pacemaker-cluster
#
#   Configure an availability group for SQL Server on Linux
#   https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-create-availability-group?view=sql-server-ver15

# 0- Environment variables | demo path
cd ~/Documents/Ubuntu-Masters/Demo_04;
SQLCMDPASSWORD='_EnDur@nc3_';
SQLCMDUSER='sa';
az aks get-credentials --resource-group ubuntu-masters --name Endurance

# 1- Simulate failure
code ./4_2_SimulateFailure.sh
./4_2_SimulateFailure.sh

NODE=`kubectl get pod -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName | grep -v NAME | awk '{print $3}'`
kubectl cordon ${NODE}

# 2- Verify SQL Server instance
# --------------------------------------
# Azure Data Studio step
# --------------------------------------

# 3- Check AKS dashboard