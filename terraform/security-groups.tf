resource "aws_security_group" "x-sgr-ec1-essential" {
  name = "x-sgr-ec1-essential"
  description = "Required starter pack for instances."
  vpc_id = aws_vpc.x-vpc-ec1.id

  tags = {
    Name = "x-sgr-ec1-essential"
    Mode = "terraform"
  }
}

// Inbound

resource "aws_vpc_security_group_ingress_rule" "allow_icmp_v4" {
  security_group_id = aws_security_group.x-sgr-ec1-essential.id
  referenced_security_group_id = aws_security_group.x-sgr-ec1-essential.id
  from_port = -1
  ip_protocol = "icmp"
  to_port = -1
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.x-sgr-ec1-essential.id
  cidr_ipv4 = aws_vpc.x-vpc-ec1.cidr_block
  from_port = 22
  ip_protocol = "tcp"
  to_port = 22
}

// Outbound

resource "aws_vpc_security_group_egress_rule" "allow_https_s3" {
  security_group_id = aws_security_group.x-sgr-ec1-essential.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 443
  ip_protocol = "tcp"
  to_port = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_https" {
  security_group_id = aws_security_group.x-sgr-ec1-essential.id
  cidr_ipv4 = aws_vpc.x-vpc-ec1.cidr_block
  from_port = 443
  ip_protocol = "tcp"
  to_port  = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_http" {
  security_group_id = aws_security_group.x-sgr-ec1-essential.id
  cidr_ipv4 = aws_vpc.x-vpc-ec1.cidr_block
  from_port = 80
  ip_protocol = "tcp"
  to_port = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_ssh_out" {
  security_group_id = aws_security_group.x-sgr-ec1-essential.id
  referenced_security_group_id = aws_security_group.x-sgr-ec1-essential.id
  from_port = 80
  ip_protocol = "tcp"
  to_port = 80
}


resource "aws_security_group" "x-sgr-ec1-load-balancer" {
  name = "x-sgr-ec1-load-balancer"
  description = "Required ports for load balancer. Open to public"
  vpc_id = aws_vpc.x-vpc-ec1.id

  tags = {
    Name = "x-sgr-ec1-web-app"
    Mode = "terraform"
  }
}

// Inbound

resource "aws_vpc_security_group_ingress_rule" "allow_http_public" {
  security_group_id = aws_security_group.x-sgr-ec1-essential.id
  referenced_security_group_id = aws_security_group.x-sgr-ec1-essential.id
  from_port = 80
  ip_protocol = "tcp"
  to_port = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_public" {
  security_group_id = aws_security_group.x-sgr-ec1-essential.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 443
  ip_protocol = "tcp"
  to_port = 443
}

// Outbound

resource "aws_vpc_security_group_egress_rule" "allow_http_out" {
  security_group_id = aws_security_group.x-sgr-ec1-essential.id
  referenced_security_group_id = aws_security_group.x-sgr-ec1-web-app.id
  from_port = 80
  ip_protocol = "tcp"
  to_port = 80
}


resource "aws_security_group" "x-sgr-ec1-web-app" {
  name = "x-sgr-ec1-web-app"
  description = "Required ports for web applications. Both front and back."
  vpc_id = aws_vpc.x-vpc-ec1.id

  tags = {
    Name = "x-sgr-ec1-web-app"
    Mode = "terraform"
  }
}

// Inbound

resource "aws_vpc_security_group_ingress_rule" "allow_http_local" {
  security_group_id = aws_security_group.x-sgr-ec1-essential.id
  cidr_ipv4 = aws_vpc.x-vpc-ec1.cidr_block
  from_port = 80
  ip_protocol = "tcp"
  to_port = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_alb" {
  security_group_id = aws_security_group.x-sgr-ec1-essential.id
  referenced_security_group_id = aws_security_group.x-sgr-ec1-load-balancer.id
  from_port = 80
  ip_protocol = "tcp"
  to_port = 80
}