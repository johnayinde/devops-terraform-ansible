provider "aws" {
  region = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_security_group" "todo_app_sg" {
  name        = "todo-app-sg"
  description = "Allow necessary ports for the TODO application"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "todo_app_server" {
  ami                    = "ami-04b4f1a9cf54c11d0" 
  instance_type          = "t2.micro"
  key_name               = "ajo-devops-key" 
  security_groups        = [aws_security_group.todo_app_sg.name]

  root_block_device {
    volume_size           = 10
    volume_type           = "gp3"
    delete_on_termination = true
    tags = {
      Name = "todo-app-root-volume"
    }
  }

  tags = {
    Name = "todo-instance"
  }
}

resource "aws_eip" "todo_app_eip" {
  instance = aws_instance.todo_app_server.id
}

resource "aws_route53_record" "todo_app_dns" {
  zone_id = var.hosted_zone_id
  name    = var.domain
  type    = "A"
  ttl     = 300
  records = [aws_eip.todo_app_eip.public_ip]
  allow_overwrite = true 

}

resource "aws_route53_record" "wildcard_dns" {
  zone_id = var.hosted_zone_id
  name    = "*.${var.domain}"
  type    = "CNAME"
  ttl     = 300
  records = [var.domain]
}

resource "local_file" "ansible_inventory" {
  depends_on = [aws_eip.todo_app_eip]

  content = <<EOT
[all]
${aws_eip.todo_app_eip.public_ip} ansible_user=ubuntu ansible_private_key_file=../ajo-devops-key.pem
EOT
  filename = "../ansible/inventory"
}

resource "null_resource" "run_ansible" {
  depends_on = [
    aws_instance.todo_app_server,
    aws_eip.todo_app_eip
  ]

  # Add triggers to ensure ansible runs when instance or IP changes
  triggers = {
    instance_id = aws_instance.todo_app_server.id
    public_ip   = aws_eip.todo_app_eip.public_ip
  }

  provisioner "local-exec" {
  command = <<-EOT
    sleep 30 && \
    ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ../ansible/inventory ../ansible/playbook.yml
  EOT
}
}
