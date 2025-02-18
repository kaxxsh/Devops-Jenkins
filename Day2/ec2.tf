provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.this.id
  instance_type = "t2.micro"

  tags = {
    Name = "kamesh-pipeline-instance"
  }
}
