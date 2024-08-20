#!/bin/bash
set -e

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <S3_BUCKET> <DEPLOYMENT_GROUP_NAME>"
    exit 1
fi

S3_BUCKET=$1
DEPLOYMENT_GROUP_NAME=$2
APPLICATION_NAME="your-application-name"

# Package the application
echo "Packaging the application..."
zip -r application.zip . -x "*.git*"

# Upload the application to S3
echo "Uploading the application to S3..."
aws s3 cp application.zip s3://$S3_BUCKET/application.zip

# Start the deployment
echo "Starting the deployment..."
DEPLOYMENT_ID=$(aws deploy create-deployment \
    --application-name $APPLICATION_NAME \
    --deployment-group-name $DEPLOYMENT_GROUP_NAME \
    --s3-location bucket=$S3_BUCKET,bundleType=zip,key=application.zip \
    --output text --query 'deploymentId')

echo "Deployment started. Deployment ID: $DEPLOYMENT_ID"

# Wait for the deployment to complete
echo "Waiting for deployment to complete..."
aws deploy wait deployment-successful --deployment-id $DEPLOYMENT_ID

if [ $? -eq 0 ]; then
    echo "Deployment completed successfully!"
else
    echo "Deployment failed. Check the AWS CodeDeploy console for more information."
    exit 1
fi

# Clean up
echo "Cleaning up..."
rm application.zip

echo "Deployment process completed."
