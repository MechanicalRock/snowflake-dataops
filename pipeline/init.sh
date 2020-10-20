#!/bin/bash
set -e
reset

STACK_NAME=snowflake-admin-administer-pipeline-stack

echo "Create the initial CloudFormation Stack"
aws cloudformation create-stack --stack-name ${STACK_NAME} --template-body file://pipeline/aws_seed.yml --parameters file://pipeline/aws_seed-cli-parameters.json --capabilities "CAPABILITY_NAMED_IAM"
echo "Waiting for the CloudFormation stack to finish being created."
aws cloudformation wait stack-create-complete --stack-name ${STACK_NAME}
# Print out all the CloudFormation outputs.
aws cloudformation describe-stacks --stack-name ${STACK_NAME} --output table --query "Stacks[0].Outputs"

