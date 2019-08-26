#!/bin/bash

RESOURCE_GROUP_NAME=RG_TFSTATE_EASTUS2
STORAGE_ACCOUNT_NAME=tfstate$RANDOM
CONTAINER_NAME=tfstate
REGION=eastus2

# Create resource group for terraform state
FLAG_RG=$(az group exists -n $RESOURCE_GROUP_NAME)

if [ "$FLAG_RG" = false ]
then
      echo "Creating resource group $RESOURCE_GROUP_NAME"
      az group create --name $RESOURCE_GROUP_NAME --location $REGION
else
      echo "Resource group $RESOURCE_GROUP_NAME already exist...skip"
fi

# Create storage account for terrraform state
FLAG_SA=$(az storage account check-name -n $STORAGE_ACCOUNT_NAME --query nameAvailable)

if [ "$FLAG_SA" = true ]
then
      echo "Creating storage account for terraform state $STORAGE_ACCOUNT_NAME"
      az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME -l $REGION --sku Standard_LRS --encryption-services blob

      echo "Creating storage container $CONTAINER_NAME"
      az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --fail-on-exist
else
      echo "Storage account $STORAGE_ACCOUNT_NAME already exist...skip"
fi

# Get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query [0].value -o tsv)

echo "storage_account_name: $STORAGE_ACCOUNT_NAME"
echo "container_name: $CONTAINER_NAME"
echo "access_key: $ACCOUNT_KEY"
