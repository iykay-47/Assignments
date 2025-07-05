provider "aws" {
  region = "us-east-2"  # Must match the AMI's region
}

resource "aws_security_group" "pckr_web_server" {
  name        = "packer_nginx_web-server-sg"
  description = "Allow HTTP, HTTPS and SSH access"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allows all traffic
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Restrict to your IP in production
  }

  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_instance" "pckr_web_server" {
  ami           = "ami-07e55163fccd80534"  # Your Packer-built AMI ID here
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.pckr_web_server.id]
  key_name      = "emage2tech"      # Replace with your EC2 key pair

  tags = {
    Name = "Packer-Config-Nginx-WebServer"
  }
}

# Standard Terraform outputs
output "public_ip" {
  value = aws_instance.pckr_web_server.public_ip
}

output "website_url" {
  value = "http://${aws_instance.pckr_web_server.public_ip}"
}

# Store outputs to local JSON file
resource "local_file" "terraform_outputs" {
  filename = "${path.module}/terraform_outputs.json"
  content = jsonencode({
    public_ip    = aws_instance.pckr_web_server.public_ip
    instance_id  = aws_instance.pckr_web_server.id
    ami_id       = aws_instance.pckr_web_server.ami
    website_url  = "http://${aws_instance.pckr_web_server.public_ip}"
    timestamp    = timestamp()
  })
}