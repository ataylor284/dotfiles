# EC2
alias aws_ec2_ls="aws ec2 describe-instances --query 'Reservations[].Instances[].[Tags[?Key==\`Name\`] | [0].Value, State.Name, PublicDnsName]' --output table"

# Cloud Formation
alias aws_cf_ls="aws cloudformation describe-stacks --query=Stacks[].[Description,StackName,StackStatus] --output=table"
alias aws_cf_params="aws cloudformation describe-stacks --query=Stacks[].[Parameters] --output=table --stack-name"
alias aws_cf_outputs="aws cloudformation describe-stacks --query=Stacks[].[Outputs] --output=table --stack-name"
alias aws_cf_resources="aws cloudformation describe-stack-resources --query StackResources[].[LogicalResourceId,PhysicalResourceId,ResourceType,ResourceStatus] --output table --stack-name"

# Lambda
alias aws_lm_ls="aws lambda list-functions --query Functions[].[FunctionName,Runtime,LastModified] --output table"
alias aws_lm_hash="aws lambda list-functions --query Functions[].[FunctionName,CodeSha256] --output table"
alias aws_lm_versions="aws lambda list-versions-by-function --query Versions[].[Version,LastModified] --output table --function-name"
alias aws_lm_aliases="aws lambda list-aliases --query Aliases[].[Name,FunctionVersion] --output table --function-name"
