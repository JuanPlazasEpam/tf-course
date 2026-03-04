project_prefix         = "cmtr-gqdgh5re-01"
aws_region             = "us-east-1"
vpc_cidr_block         = "10.10.0.0/16"
public_subnet_azs      = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnet_cidrs    = ["10.10.1.0/24", "10.10.3.0/24", "10.10.5.0/24"]
public_subnet_suffixes = ["a", "b", "c"]
default_tags = {
  Environment = "lab"
  ManagedBy   = "terraform"
}

