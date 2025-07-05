# Required to initalize packer

packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

# Declare Variables to prevenet repititions.

# Set aws region
variable "aws_region" {
  type    = string
  default = "us-east-2"
}

# Source Image for Pcker to build from

variable "source_ubuntu_ami" {
  type    = string
  default = "ami-0d1b5a8c13042c939"
}

# Instance type

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

# User name for packer to ssh login and carry out config 

variable "ssh_username" {
  type    = string
  default = "ubuntu"
}

source "amazon-ebs" "nginx-ubuntu" {
  region          = var.aws_region
  source_ami      = var.source_ubuntu_ami
  instance_type   = var.instance_type
  ssh_username    = var.ssh_username
  ami_name        = "nginx-ubuntu-ami"
  ami_description = "Custom AMI with Nginx installed and configured"
  
  tags = {
    Name        = "nginx-ubuntu-ami"
    OS_Version  = "Ubuntu 24.04 LTS"
    Release     = "Latest"
    Created_By  = "Packer"
  }
}

build {
  sources = ["source.amazon-ebs.nginx-ubuntu"]

# Install Nginx and configure custom html page

    provisioner "shell" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install nginx -y",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",
      "sudo echo '<h3>Image creation and deploymemt successful. Your IP address is: <h2>$(hostname -i)</h2> </h3>' > /tmp/index.html"
    ]
  }

  provisioner "shell" {
    inline = [
      "sudo mv /tmp/index.html /var/www/html/index.html",
      "sudo chown www-data:www-data /var/www/html/index.html",
      "sudo systemctl restart nginx"
    ]
  }

}