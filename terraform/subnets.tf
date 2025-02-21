resource "aws_subnet" "x-sbn-1a-public" {
  vpc_id     = aws_vpc.x-vpc-ec1.id
  cidr_block = "192.168.0.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "x-sbn-1a-public"
    Mode = "terraform"
  }
}

resource "aws_subnet" "x-sbn-1a-private" {
  vpc_id     = aws_vpc.x-vpc-ec1.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "x-sbn-1a-private"
    Mode = "terraform"
  }
}

resource "aws_subnet" "x-sbn-1b-public" {
  vpc_id     = aws_vpc.x-vpc-ec1.id
  cidr_block = "192.168.2.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name = "x-sbn-1b-public"
    Mode = "terraform"
  }
}

resource "aws_subnet" "x-sbn-1b-private" {
  vpc_id     = aws_vpc.x-vpc-ec1.id
  cidr_block = "192.168.3.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name = "x-sbn-1b-private"
    Mode = "terraform"
  }
}

resource "aws_subnet" "x-sbn-1c-public" {
  vpc_id     = aws_vpc.x-vpc-ec1.id
  cidr_block = "192.168.4.0/24"
  availability_zone = "eu-central-1c"

  tags = {
    Name = "x-sbn-1c-public"
    Mode = "terraform"
  }
}

resource "aws_subnet" "x-sbn-1c-private" {
  vpc_id     = aws_vpc.x-vpc-ec1.id
  cidr_block = "192.168.5.0/24"
  availability_zone = "eu-central-1c"

  tags = {
    Name = "x-sbn-1c-private"
    Mode = "terraform"
  }
}