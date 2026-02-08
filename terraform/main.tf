provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "trend_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "trend_subnet" {
  vpc_id = aws_vpc.trend_vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_security_group" "trend_sg" {
  vpc_id = aws_vpc.trend_vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jenkins_server" {
  ami = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.medium"
  subnet_id = aws_subnet.trend_subnet.id
  vpc_security_group_ids = [aws_security_group.trend_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install openjdk-17-jdk -y
              wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -
              echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list
              apt update -y
              apt install jenkins -y
              systemctl start jenkins
              EOF
}
