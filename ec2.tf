# Provider name: Amazon AWS 
provider "aws" {
  region     = "us-east-1"
}

# Create an EC2 in AWS with TAG
resource "aws_instance" "Server_East1" {
  ami           = "ami-01cc34ab2709337aa"
  instance_type = "t2.micro"

  tags = {
    name = "Prod_Env"
  }
}

# Create a Security Group
resource "aws_security_group" "my_Sec_Group" {
  name = "Sec-variables"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

}

# Create a new S3 BUCKET
resource "aws_s3_bucket" "bucket_test" {
  bucket = "my-tf-test-bucket"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev_Env"
  }
}

# Create an Elastic IP
resource "aws_eip" "lb" {
  vpc = true

  # Output the result of the Elastic IP
}
output "eip" {
  value = aws_eip.lb.public_ip
}

# Elastic IP Association 
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.Server_East1.id
  allocation_id = aws_eip.lb.id

}

