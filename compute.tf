resource "aws_instance" "cmtr_instance" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = "t3.micro"
  subnet_id     = data.aws_subnet.public.id

  vpc_security_group_ids = [
    data.aws_security_group.ec2.id,
  ]

  tags = {
    Name      = "cmtr-gqdgh5re-instance"
    Terraform = "true"
    Project   = var.project_id
  }
}
