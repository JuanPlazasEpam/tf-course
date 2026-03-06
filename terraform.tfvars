allowed_ip_range       = ["18.153.146.156/32", "200.118.18.42/32"]
project_id             = "cmtr-gqdgh5re"
aws_region             = "us-east-1"
project_prefix         = "cmtr-gqdgh5re-01"
vpc_cidr_block         = "10.10.0.0/16"
public_subnet_azs      = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnet_cidrs    = ["10.10.1.0/24", "10.10.3.0/24", "10.10.5.0/24"]
public_subnet_suffixes = ["a", "b", "c"]
default_tags = {
  Environment = "lab"
  ManagedBy   = "terraform"
}

