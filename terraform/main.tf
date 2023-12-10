#TERRAFORM as IAC


provider "aws" {
  region = "us-west-2"
  access_key = ""
  secret_key = ""
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2b"
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_nat_gateway" "my_nat_gateway" {
  allocation_id = aws_eip.my_eip.id
  subnet_id     = aws_subnet.public_subnet.id
}

resource "aws_eip" "my_eip" {
    domain = "vpc"
}

resource "aws_security_group" "ec2_SG" {
  name = "ec2-sg"
  description = "allow ssh"
  vpc_id = aws_vpc.my_vpc.id
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "ec2_instances" {
  count         = 2
  ami           = "ami-0efcece6bed30fd98"  # Replace with your desired AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.ec2_SG.id]

  tags = {
    Name = "Instance0${count.index + 1}"
  }
}

