# This is my first Terraform configuration file

# Specify the provide, in my case I am using AWS
provider "aws" {
  region = "us-west-2"
}

# create an ec2 instance
resource "aws_instance" "my_first_ec2" {
  ami           = "ami-03aa99ddf5498ceb9" # add the Amazon Linux AMI ID
  instance_type = "t3.micro" # add the instance type

  tags = {
    Name = "MyFirstEC2Instance"
  }
}
