# EC2
alias aws_ec2_ls="aws ec2 describe-instances --query 'Reservations[].Instances[].[InstanceId, Tags[?Key==\`Name\`] | [0].Value, State.Name, PublicDnsName]' --output table"
alias aws_ec2_ips="aws ec2 describe-instances --query 'Reservations[0].Instances[0].[PublicDnsName,PublicIpAddress,PrivateIpAddress]' --output table --instance-ids"
alias aws_ec2_key="aws ec2 describe-instances --query Reservations[0].Instances[0].KeyName --output text --instance-ids"
alias aws_ec2_type="aws ec2 describe-instances --query Reservations[0].Instances[0].InstanceType --output text --instance-ids"
alias aws_ec2_stack="aws ec2 describe-instances --query 'Reservations[].Instances[].[Tags[?Key==\`aws:cloudformation:stack-name\`] | [0].Value]' --output text --instance-ids"
alias aws_ec2_console="aws ec2 get-console-output --query Output --output text --instance-id"
alias aws_ec2_spot_ls="aws ec2 describe-spot-instance-requests  --query SpotInstanceRequests[].[SpotInstanceRequestId,InstanceId,Status.Code,LaunchSpecification.InstanceType,SpotPrice] --output table"
aws_ec2_spot_price() { aws ec2 describe-spot-price-history --max-items 1 --query SpotPriceHistory[0].SpotPrice --output text --product-descriptions 'Linux/UNIX' --instance-types $1 | head -1; }
alias aws_ec2_ami_ls="aws ec2 describe-images --owners self --query Images[].[Name,ImageId,State] --output table"

# Cloud Formation
alias aws_cf_ls="aws cloudformation describe-stacks --query=Stacks[].[Description,StackName,StackStatus] --output=table"
alias aws_cf_names="aws cloudformation describe-stacks --query=Stacks[].[StackName] --output=text"
alias aws_cf_params="aws cloudformation describe-stacks --query=Stacks[].[Parameters] --output=table --stack-name"
alias aws_cf_outputs="aws cloudformation describe-stacks --query=Stacks[].[Outputs] --output=table --stack-name"
alias aws_cf_resources="aws cloudformation describe-stack-resources --query StackResources[].[LogicalResourceId,PhysicalResourceId,ResourceType,ResourceStatus] --output table --stack-name"
alias aws_cf_events="aws cloudformation describe-stack-events --query StackEvents[].[Timestamp,ResourceStatus,LogicalResourceId,ResourceType] --output table --stack-name"
alias aws_cf_event_reasons="aws cloudformation describe-stack-events --query StackEvents[].[LogicalResourceId,ResourceStatusReason] --output table --stack-name"
alias aws_cf_rm="aws cloudformation delete-stack --stack-name"
aws_cf_resource_name() { aws cloudformation describe-stack-resources --stack-name $1 --logical-resource-id $2 --query StackResources[].[PhysicalResourceId] --output text; }

# Lambda
alias aws_lm_ls="aws lambda list-functions --query Functions[].[FunctionName,Runtime,LastModified] --output table"
alias aws_lm_names="aws lambda list-functions --query Functions[].[FunctionName] --output text"
alias aws_lm_hash="aws lambda list-functions --query Functions[].[FunctionName,CodeSha256] --output table"
alias aws_lm_versions="aws lambda list-versions-by-function --query Versions[].[Version,LastModified] --output table --function-name"
alias aws_lm_aliases="aws lambda list-aliases --query Aliases[].[Name,FunctionVersion] --output table --function-name"

# DynamoDB
alias aws_dy_ls="aws dynamodb list-tables --query TableNames[][@] --output text"
alias aws_dy_keys="aws dynamodb describe-table --query Table.KeySchema --output table --table-name"
alias aws_dy_attributes="aws dynamodb describe-table --query Table.AttributeDefinitions --output table --table-name"
aws_dy_nth_row() { aws dynamodb scan --max-items $(($2 + 1)) --query 'Items['$2'].[keys(@), values(@)[].[S||N][]]' --output table --table-name $1; }

# Kinesis Firehose
alias aws_fh_ls="aws firehose list-delivery-streams --limit=200 --query DeliveryStreamNames[][@] --output text"
alias aws_fh_dests="aws firehose describe-delivery-stream --query DeliveryStreamDescription.Destinations --output table --delivery-stream-name"
alias aws_fh_rm="aws firehose delete-delivery-stream --delivery-stream-name"

# S3
alias aws_s3_stack="aws s3api get-bucket-tagging --query 'TagSet[?Key==\`aws:cloudformation:stack-name\`] | [0].Value' --output text --bucket"

# Cloud Trail
alias aws_ct_events="aws cloudtrail lookup-events --max-results 15 --query Events[].[EventTime,Username,EventName] --output table"

# Events
alias aws_ev_ls="aws events list-rules --query Rules[].[Name,ScheduleExpression,State] --output table"
alias aws_ev_targets="aws events list-targets-by-rule --query Targets[].[Id,Arn] --output table --rule"
aws_ev_rm_target() { aws events remove-targets --rule $1 --ids $2 --output table; }
alias aws_ev_rm="aws events delete-rule --name"

# Logs
# Prefix with MSYS_NO_PATHCONV=1 under windows if bash is mangling log group names
alias aws_log_ls="aws logs describe-log-groups --query logGroups[].[logGroupName,storedBytes] --output table"
alias aws_log_streams="aws logs describe-log-streams  --query logStreams[].[lastEventTimestamp,logStreamName] --output table --log-group-name"
aws_log_cat() { aws logs get-log-events --log-group-name $1 --log-stream-name $2 --query events[].[message] --output text | sed '/^$/d'; }

# Alarms
alias aws_al_ls="aws cloudwatch describe-alarms --query MetricAlarms[].[AlarmName,Dimensions[0].Name,Dimensions[0].Value] --output table"

# Roles
alias aws_rl_ls="aws iam list-roles --query Roles[].[RoleName] --output text"
alias aws_rl_policies="aws iam list-role-policies --output text --query PolicyNames[].[@] --role-name"
aws_rl_role_policy() { aws iam get-role-policy --role-name $1 --policy-name $2 --query PolicyDocument; }
