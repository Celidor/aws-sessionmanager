# aws-sessionmanager
AWS EC2 instance using Systems Manager Session Manager

## how to deploy
* if deploying from your laptop, duplicate `terraform.tfvars.example`
* rename without the `.example` suffix
* enter details and save
* if deploying via a CI/CD pipeline, enter variable values in your pipeline
```
terraform workspace new dev
terraform plan
terraform apply
```

## remote SSH session in browser
* A remote SSH session in the AWS console doesn't require a SSH key
* In the AWS Console, EC2, select the instance
<img src="images/instance.png" width="500">
* Press Connect
* Choose the Session Manager tab
<img src="images/connect.png" width="400">
* You now have a remote SSH session in your browser
<img src="images/session.png" width="200">

## AWS CLI session from laptop - usage
* allows copying and pasting but not SCP
* ensure you have AWS CLI v2
* [install the AWS CLI Session Manager plugin](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html)
* open Terminal
* use default credentials, or export AWS credentials to your session
```
aws ssm start-session --target i-08d33c2c6302550fa --region eu-west-1
```

## remote SSH session from laptop - setup
SSH from your laptop allowing use of SCP to transfer files
* requires SSH public key on instance
* ensure you have AWS CLI v2
* [install the AWS CLI Session Manager plugin](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html)
* open Terminal
* add the following to your SSH config file at `~/.ssh/config`
```
# SSH over Session Manager
host i-* mi-*
    ProxyCommand sh -c "aws ssm start-session --target %h --document-name AWS-StartSSHSession --parameters 'portNumber=%p'"
```

## remote SSH session from laptop - usage
SSH from your laptop allowing use of SCP to transfer files
* open Terminal
* use default credentials, or export AWS credentials to your session
* if AWS region isn't specified in exported AWS credentials:
```
export AWS_REGION=eu-west-1
```
* connect using SSH from laptop (assuming default SSH key used)
```
ssh ec2-user@i-08d33c2c6302550fa
```
<img src="images/ssh-session.png" width="500">

## scp files from laptop to EC2 instance
* SCP from laptop (assuming default SSH key used)
```
scp Desktop/sample-file.txt ec2-user@i-08d33c2c6302550fa:~
```
<img src="images/scp.png" width="500">

## port forwarding from laptop to service on the host
* connect using SSH from laptop (assuming default SSH key used)
```
ssh ec2-user@i-08d33c2c6302550fa
```
* install Apache
```
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
```
* logout
```
exit
```
* set up port forwarding
```
aws ssm start-session \         
    --target i-08d33c2c6302550fa \
    --document-name AWS-StartPortForwardingSession \
    --parameters '{"portNumber":["80"], "localPortNumber":["9999"]}'
```
* browse to `localhost:9999`
<img src="images/apache.png">