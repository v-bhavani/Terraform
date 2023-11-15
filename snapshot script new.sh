#!/bin/bash

echo "Checking snapshots in Demo Account" 


# Get your AWS account ID
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --output text --query 'Account')

# Get the current date in YYYY-MM-DD format
current_date=$(date '+%Y-%m-%d')

# Set the S3 bucket and object key
S3_BUCKET="testiambucket1"
S3_KEY="snapshot_list_$current_date.csv"

# Set file names for today
current_day_file="snapshot_list_$current_date.csv"
current_day_file_path="/tmp/$current_day_file"

# Set file name for yesterday
previous_day_file="snapshot_list_$(date -d "yesterday" "+%Y-%m-%d").csv"
previous_day_file_path="/tmp/$previous_day_file"

# Use the AWS CLI to download yesterday's CSV file from S3
aws s3 cp s3://$S3_BUCKET/$previous_day_file $previous_day_file_path

# Use the AWS CLI to list snapshots owned by your AWS account and store the output in a file
aws ec2 describe-snapshots --region $AWS_DEFAULT_REGION --owner-ids $AWS_ACCOUNT_ID --output json > snapshot_output.json

# Extract relevant information from the JSON output
snapshot_ids=$(jq -r '.Snapshots[].SnapshotId' snapshot_output.json)

# Save the output to a CSV file for today and count the snapshots
echo "Snapshot ID" > $current_day_file_path
snapshot_count=0
for id in $snapshot_ids; do
    echo "$id" >> $current_day_file_path
    ((snapshot_count++))
done
echo "Snapshot Count for $current_date (AWS Account ID: $AWS_ACCOUNT_ID): $snapshot_count"

# Use the AWS CLI to copy today's CSV file to S3
aws s3 cp /tmp/snapshot_list_$current_date.csv s3://$S3_BUCKET/$S3_KEY

# Compare with the previous day's CSV file
if [ -e $previous_day_file_path ]; then
    echo "Comparing with the previous day's snapshot list..."
    diff_output=$(diff $previous_day_file_path $current_day_file_path)
    
    if [ $? -eq 0 ]; then
        echo "No differences found."
    else
        echo "Differences found:"
        echo "$diff_output"
        # Count the differences
        diff_count=$(diff -y --suppress-common-lines $previous_day_file_path $current_day_file_path | wc -l)
        echo "Difference Count: $diff_count"
    fi
else
    echo "No previous day's snapshot list found for comparison."
fi

# Clean up the temporary files
rm $current_day_file_path
rm $previous_day_file_path
rm snapshot_output.json
