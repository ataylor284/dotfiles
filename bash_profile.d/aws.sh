# EC2
alias aws_ec2_ls="aws ec2 describe-instances --query 'Reservations[].Instances[].[Tags[?Key==\`Name\`] | [0].Value, State.Name, PublicDnsName]' --output table"

# Cloud Formation
alias aws_cf_ls="aws cloudformation describe-stacks --query=Stacks[].[Description,StackName,StackStatus] --output=table"
alias aws_cf_outputs="aws cloudformation describe-stacks --query=Stacks[].[Outputs] --output=table --stack-name"
alias aws_cf_resources="aws cloudformation describe-stack-resources --query StackResources[].[LogicalResourceId,ResourceType,ResourceStatus] --output table --stack-name"
