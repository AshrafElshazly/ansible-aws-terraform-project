provider "aws" {
  region = var.region
}

resource "aws_vpc" "lab" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "lab"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.lab.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_internet_gateway" "lab_IGW" {
  vpc_id = aws_vpc.lab.id

  tags = {
    Name = "lab-IGW"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.lab.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab_IGW.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "ansible_SG" {
  name   = "ansible-SG"
  vpc_id = aws_vpc.lab.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ansible_SG"
  }
}

resource "aws_instance" "mngmt-server" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.ansible_SG.id]
  subnet_id              = aws_subnet.public_subnet.id

  user_data = file("user-data.sh")
  tags = {
    Name = "mngmt-server"
  }
}

resource "aws_instance" "server" {
  count         = 2
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.ansible_SG.id]
  subnet_id              = aws_subnet.public_subnet.id
  tags = {
    Name = "server-${count.index + 1}"
  }
}
