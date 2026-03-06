resource "aws_launch_template" "blue" {
  name_prefix   = "cmtr-gqdgh5re-blue-template"
  image_id      = data.aws_ami.al2023.id
  instance_type = "t3.micro"
  key_name      = var.ssh_key_name

  iam_instance_profile {
    name = var.iam_instance_profile
  }

  network_interfaces {
    device_index                = 0
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = [data.aws_security_group.ssh.id, data.aws_security_group.http.id]
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  user_data = base64encode(<<-EOT
#!/bin/bash
yum update -y
yum install -y httpd
systemctl enable httpd
systemctl start httpd
cat >/var/www/html/index.html <<HTML
<html><body><h1>Blue Environment</h1></body></html>
HTML
EOT
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Terraform   = "true"
      Project     = var.project_id
      Environment = "blue"
    }
  }
}

resource "aws_launch_template" "green" {
  name_prefix   = "cmtr-gqdgh5re-green-template"
  image_id      = data.aws_ami.al2023.id
  instance_type = "t3.micro"
  key_name      = var.ssh_key_name

  iam_instance_profile {
    name = var.iam_instance_profile
  }

  network_interfaces {
    device_index                = 0
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = [data.aws_security_group.ssh.id, data.aws_security_group.http.id]
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  user_data = base64encode(<<-EOT
#!/bin/bash
yum update -y
yum install -y httpd
systemctl enable httpd
systemctl start httpd
cat >/var/www/html/index.html <<HTML
<html><body><h1>Green Environment</h1></body></html>
HTML
EOT
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Terraform   = "true"
      Project     = var.project_id
      Environment = "green"
    }
  }
}
