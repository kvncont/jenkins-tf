#!/bin/bash

RESOURCE_GROUP_NAME=tstate
STORAGE_ACCOUNT_NAME=tstate$RANDOM
CONTAINER_NAME=tstate
REGION=eastus2

# Create resource group from terraform state
FLAG_RG=$(az group exists -n $RESOURCE_GROUP_NAME)

if [ "$FLAG_RG" = false ]
then
      echo "Step 1. Creating resource group $RESOURCE_GROUP_NAME"
      az group create --name $RESOURCE_GROUP_NAME --location $REGION
else
      echo "Step 1. Resource group $RESOURCE_GROUP_NAME already exist...skip"
fi

# # Create storage account from terraform state
# az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# # Get storage account key
# ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query [0].value -o tsv)

# # Create blob container
# az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY

# echo "storage_account_name: $STORAGE_ACCOUNT_NAME"
# echo "container_name: $CONTAINER_NAME"
# echo "access_key: $ACCOUNT_KEY"