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