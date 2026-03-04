aws_region = "us-east-1"

default_tags = {
  Environment = "lab"
  ManagedBy   = "terraform"
}

project_id              = "cmtr-gqdgh5re-02"
aws_keypair_name        = "tf-lab-keypair"
aws_instance_name       = "tf-lab-ec2"
aws_security_group_name = "tf-lab-ec2-sg"

aws_instance_ami  = "ami-000539d6cf7e20d95"
aws_instance_type = "t3.micro"