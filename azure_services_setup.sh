#!/bin/bash

# This script is used to set up additional Azure services for the Airsonic application.

# Login to Azure (assumes Azure CLI is installed and configured with credentials)
az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID

# Create Azure SQL Database
echo "Creating Azure SQL Database..."
az sql db create --name $SQL_DATABASE_NAME --server $SQL_SERVER_NAME --resource-group $AZURE_RESOURCE_GROUP --sample-name AdventureWorksLT

# Create Azure Blob Storage
echo "Creating Azure Blob Storage..."
az storage account create --name $STORAGE_ACCOUNT_NAME --resource-group $AZURE_RESOURCE_GROUP --location $AZURE_LOCATION --sku Standard_LRS

# Set up Azure Application Insights
echo "Setting up Azure Application Insights..."
az monitor app-insights component create --app $APP_INSIGHTS_NAME --location $AZURE_LOCATION --resource-group $AZURE_RESOURCE_GROUP --application-type web

# Note: Environment variables AZURE_CLIENT_ID, AZURE_CLIENT_SECRET, AZURE_TENANT_ID, AZURE_RESOURCE_GROUP, AZURE_LOCATION,
# SQL_DATABASE_NAME, SQL_SERVER_NAME, STORAGE_ACCOUNT_NAME, and APP_INSIGHTS_NAME should be set with the appropriate values before running this script.
