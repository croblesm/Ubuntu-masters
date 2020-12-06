# Demo 04 - SQL Server HA in Kubernetes
#   1- Check PVC and volume provisioned on Kubernetes
#   2- Connect to SQL Server to create new database
#   3- Simulate failure (delete pod)
#   4- Connect using Azure Data Studio
#   5- Get SQL Server instance and database properties
#   6- Browse Kubernetes dashboard
# -----------------------------------------------------------------------------
# References
#   Kubernetes cheat sheet
#   https://kubernetes.io/docs/reference/kubectl/cheatsheet/
#
#   Kubernetes Dashboard
#   https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md
#   https://collabnix.com/kubernetes-dashboard-on-docker-desktop-for-windows-2-0-0-3-in-2-minutes/

# 0- Environment variables | demo path
cd ~/Documents/Ubuntu-Masters/Demo_04;
SQLCMDPASSWORD='_EnDur@nc3_';
SQLCMDUSER='sa';
az aks get-credentials --resource-group ubuntu-masters --name Endurance

# 1- Simulate failure
code ./4_2_SimulateFailure.sh
./4_2_SimulateFailure.sh

# 2- Verify SQL Server instance
# --------------------------------------
# Azure Data Studio step
# --------------------------------------