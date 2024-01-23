#!/bin/bash

# Set your subscription name
subscription=$subs

# Set the storage account details
storage_account_name="$staccount"
container_name="$container"
csv_filename="$filename"

# Set the SAS token (replace with your actual SAS token)
sas_token="$sastoken"

# Run the Azure CLI command and output the results in JSON format
json_output=$(az monitor metrics alert list --subscription $subscription --query '[].{Name:name, Scope:scopes[0], TargetResourceType:targetResourceType, Operator:criteria.allOf[0].operator, Threshold:criteria.allOf[0].threshold, Severity:severity, State:enabled}' --output json)

# Convert JSON to CSV using jq, add header row, and save it to a local file
echo "Name,Scope,Target Resource Type,Operator,Threshold,Severity,State" > "$csv_filename"
echo "$json_output" | jq -r '.[] | [.Name, .Scope, .TargetResourceType, .Operator, .Threshold, .Severity, .State] | @csv' >> "$csv_filename"

# Upload the CSV file to the Azure Storage Account using SAS token
az storage blob upload --account-name $storage_account_name --container-name $container_name --name $csv_filename --type block --file $csv_filename --sas-token $sas_token

# Clean up: Optionally, remove the local CSV file after uploading
rm $csv_filename
