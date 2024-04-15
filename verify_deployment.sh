#!/bin/bash

# This script is used to verify the deployment of the Airsonic application in the Azure Kubernetes Service (AKS).

# Login to Azure (assumes Azure CLI is installed and configured with credentials)
az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID

# Get credentials for AKS
az aks get-credentials --resource-group $AZURE_RESOURCE_GROUP --name $AKS_CLUSTER_NAME

# Check the status of the AKS cluster
echo "Checking the status of the AKS cluster..."
az aks show --resource-group $AZURE_RESOURCE_GROUP --name $AKS_CLUSTER_NAME --query "provisioningState"

# List the pods in the AKS cluster
echo "Listing the pods in the AKS cluster..."
kubectl get pods

# Describe the Airsonic deployment
echo "Describing the Airsonic deployment..."
kubectl describe deployment airsonic

# Get the service to find the external IP
echo "Getting the Airsonic service to find the external IP..."
kubectl get service airsonic

# Check the logs of the first pod
first_pod=$(kubectl get pods -l app=airsonic -o jsonpath="{.items[0].metadata.name}")
echo "Checking the logs of the first pod: $first_pod"
kubectl logs $first_pod

# Note: Environment variables AZURE_CLIENT_ID, AZURE_CLIENT_SECRET, AZURE_TENANT_ID, AZURE_RESOURCE_GROUP, and AKS_CLUSTER_NAME
# should be set with the appropriate values before running this script.
