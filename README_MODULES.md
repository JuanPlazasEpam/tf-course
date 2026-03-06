Overview
--------
This workspace contains three Terraform modules under `modules/`:

- `modules/network` — creates VPC, public subnets, internet gateway, route table and associations.
- `modules/network_security` — creates SSH, public HTTP, and private HTTP security groups.
- `modules/application` — creates a Launch Template, an Application Load Balancer, Target Group, Listener, Auto Scaling Group, and attaches the ASG to the TG.

Usage
-----
1. Update `terraform.tfvars` and replace `YOUR_PUBLIC_IP/32` with your actual CIDR.
2. Run:

```powershell
terraform init
terraform fmt -recursive
terraform validate
terraform plan -var-file=terraform.tfvars
```

Notes
-----
- I could not run `terraform apply` here; run it locally. Review the ALB naming: the application module creates an ALB named `${project_id}-lb`. If an ALB with the same name already exists, either delete it or modify the module to use a `data "aws_lb"` lookup instead.
- The application module creates a target group named `${project_id}-tg`. If you prefer separated named target groups per environment or blue/green, modify accordingly.
