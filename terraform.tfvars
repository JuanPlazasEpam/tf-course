aws_region = "us-east-1"

default_tags = {
  Environment = "lab"
  ManagedBy   = "terraform"
}

project_id              = "cmtr-gqdgh5re"
aws_keypair_name        = "cmtr-gqdgh5re-keypair"
aws_instance_name       = "cmtr-gqdgh5re-ec2"
aws_security_group_name = "cmtr-gqdgh5re-sg"

aws_instance_ami  = "ami-000539d6cf7e20d95"
aws_instance_type = "t3.micro"