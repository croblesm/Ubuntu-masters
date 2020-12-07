#!/bin/bash

#####################################################################
# Script name:    Simulate pod failure                                                                                              
# Description:    This script will delete the existing SQL Server pod                                                                                 
# Author:         Carlos Robles
# Email:          crobles@dbamastery.com
#####################################################################

# Variables
k8s_cluster=endurance-admin;
namespace=plex-sql;

# Setting kubectl context to desired cluster 
echo -e  "Setting kubectl context to Docker desktop\n"
kubectl config use-context $k8s_cluster
kubectl config set-context --current --namespace=$namespace

echo -e "=============================================="
echo -e "  Simulating failure" 
echo -e "=============================================="
echo -e "  Start time:" `date +"%T"`
echo -e "=============================================="

# Checking pod status
echo -e "\nGetting status of curent pods:"
echo -e "**********************************************\n"
kubectl get pods -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName

# Getting pod name
pod=`kubectl get pods -l app=sql-plex --no-headers -o custom-columns=":metadata.name"`

# Deleting pods
echo -e "\n Deleting pods / Simulating pod failure"
echo -e "********************************************** \n"
kubectl delete pod $pod --grace-period=0 --force

# Setting star time for timer
start_time="$(date -u +%s)"

# Wait for pod to be deleted
#sleep 10
status=0
while [ $status -le 0 ]
do
  echo -e "\nWaiting for new pod ... "
  status=`kubectl get pods --field-selector=status.phase=Running | grep sql-plex | wc -l`
  sleep 2
done

# Setting end time for timer
end_time="$(date -u +%s)"

# Get pods
echo -e "\nGetting status of new pod:\n"
echo -e "**********************************************\n"
sleep 4
kubectl get pods -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName

# Get latest pod status
echo -e "\nChecking SQL Server logs from latest pod:"
echo -e "**********************************************\n"
new_pod=`kubectl get pods -l app=sql-plex --no-headers -o custom-columns=":metadata.name"`
kubectl logs $new_pod

# Calculating outage
elapsed="$(($end_time-$start_time))"

echo -e "=============================================="
echo -e "  Script finished           " 
echo -e "  Stop time:" `date +"%T"`
echo -e "  Outage in seconds: $elapsed"
echo -e "=============================================="