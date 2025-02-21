resource "aws_vpc" "x-vpc-ec1" {
  cidr_block = "192.168.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "x-vpc-ec1"
    Mode = "terraform"
  }
}

resource "aws_key_pair" "runner" {
    key_name = "runner"
    public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKhTmcc/YQb+80LHbITA+LPUAbxspqOVwOgDe6fxOg6e odin@Zen"

    tags = {
        Name = "runner"
        Mode = "terraform"
    }
}

resource "aws_vpc_endpoint" "x-endpoint-s3" {
  vpc_id = aws_vpc.x-vpc-ec1.id
  service_name = "com.amazonaws.eu-central-1.s3"
  route_table_ids = [
    aws_route_table.x-rtb-ec1-public.id, 
    aws_route_table.x-rtb-ec1-private.id
  ]

  tags = {
    Name = "x-endpoint-s3"
    Mode = "terraform"
  }
}

resource "aws_ec2_instance_connect_endpoint" "x-endpoint-ssh" {
    subnet_id = aws_subnet.x-sbn-1a-public.id
    security_group_ids = [ aws_security_group.x-sgr-ec1-essential.id ]

    tags = {
        Name = "x-endpoint-ssh"
        Mode = "terraform"
    }
}

resource "aws_eip" "x-eip-ec1" {
  domain = "vpc"

  tags = {
    Name = "x-eip-ec1"
    Mode = "terraform"
  }
}

resource "aws_eip" "x-eip-ec1-runner" {
  domain = "vpc"

  tags = {
    Name = "x-eip-ec1-runner"
    Mode = "terraform"
  }
}

resource "aws_eip_association" "runner-eip-association" {
  instance_id   = aws_instance.x-ec2-ec1-1b-runner.id
  allocation_id = aws_eip.x-eip-ec1-runner.id
}

resource "aws_internet_gateway" "x-igw-ec1" {
  vpc_id = aws_vpc.x-vpc-ec1.id

  tags = {
    Name = "x-igw-ec1"
    Mode = "terraform"
  }
}

resource "aws_nat_gateway" "x-ngw-ec1" {
  allocation_id = aws_eip.x-eip-ec1.id
  subnet_id = aws_subnet.x-sbn-1a-public.id

  tags = {
    Name = "x-ngw-ec1"
  }

  depends_on = [aws_internet_gateway.x-igw-ec1]
}