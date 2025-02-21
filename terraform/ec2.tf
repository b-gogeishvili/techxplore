resource "aws_instance" "terraforming-b" {
  ami = "ami-0764af88874b6b852"
  instance_type = "t3.micro"

  availability_zone = "eu-central-1b"
  subnet_id = aws_subnet.x-sbn-1b-private.id
  security_groups = [ aws_security_group.x-sgr-ec1-essential.id ]

  metadata_options {
    http_endpoint = "enabled"
  }

  tags = {
    Name = "terraforming"
    Mode = "terraform"
  }
}

resource "aws_instance" "terraforming-c" {
  ami = "ami-0764af88874b6b852"
  instance_type = "t3.micro"

  availability_zone = "eu-central-1c"
  subnet_id = aws_subnet.x-sbn-1c-private.id
  security_groups = [ aws_security_group.x-sgr-ec1-essential.id ]

  metadata_options {
    http_endpoint = "enabled"
  }

  tags = {
    Name = "terraforming"
    Mode = "terraform"
  }
}

resource "aws_instance" "terraforming-a" {
  ami = "ami-0764af88874b6b852"
  instance_type = "t3.micro"

  availability_zone = "eu-central-1a"
  subnet_id = aws_subnet.x-sbn-1a-public.id
  security_groups = [ aws_security_group.x-sgr-ec1-essential.id ]

  metadata_options {
    http_endpoint = "enabled"
  }

  tags = {
    Name = "terraforming"
    Mode = "terraform"
  }
}