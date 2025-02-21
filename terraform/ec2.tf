// Management

resource "aws_instance" "x-ec2-ec1-1b-runner" {
  ami = "ami-0c8db01b2e8e5298d"
  instance_type = "t3.medium"

  availability_zone = "eu-central-1b"
  subnet_id = aws_subnet.x-sbn-1b-public.id
  security_groups = [ 
    aws_security_group.x-sgr-ec1-essential.id,
    aws_security_group.x-sgr-ec1-runner.id
  ]

  key_name = aws_key_pair.runner.key_name

  user_data = <<EOF
#!/bin/bash
sudo yum update
EOF

  root_block_device {
    volume_size = 15
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
  }

  tags = {
    Name = "x-ec2-ec1-1b-runner"
    Mode = "terraform"
  }
}

resource "aws_instance" "x-ec2-ec1-1b-mgmt" {
  ami = "ami-0c8db01b2e8e5298d"
  instance_type = "t3.small"

  availability_zone = "eu-central-1b"
  subnet_id = aws_subnet.x-sbn-1b-private.id
  security_groups = [ 
    aws_security_group.x-sgr-ec1-essential.id
  ]

  key_name = aws_key_pair.runner.key_name

  user_data = <<EOF
#!/bin/bash
sudo yum update
EOF

  root_block_device {
    volume_size = 15
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
  }

  tags = {
    Name = "x-ec2-ec1-1b-mgmt"
    Mode = "terraform"
  }
}


// Back End

resource "aws_instance" "x-ec2-ec1-1b-backend" {
  ami = "ami-0c8db01b2e8e5298d"
  instance_type = "t3.small"

  availability_zone = "eu-central-1b"
  subnet_id = aws_subnet.x-sbn-1b-private.id
  security_groups = [ 
    aws_security_group.x-sgr-ec1-essential.id,
    aws_security_group.x-sgr-ec1-web-app.id
  ]

  key_name = aws_key_pair.runner.key_name

  user_data = <<EOF
#!/bin/bash
sudo yum update
sudo yum install -y nginx
sudo sh -c "hostname > /usr/share/nginx/html/index.html"
sudo systemctl enable --now nginx
EOF

  root_block_device {
    volume_size = 15
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
  }

  tags = {
    Name = "x-ec2-ec1-1b-backend"
    Mode = "terraform"
  }
}

resource "aws_instance" "x-ec2-ec1-1c-backend-0" {
  ami = "ami-0c8db01b2e8e5298d"
  instance_type = "t3.small"

  availability_zone = "eu-central-1c"
  subnet_id = aws_subnet.x-sbn-1c-private.id
  security_groups = [ 
    aws_security_group.x-sgr-ec1-essential.id,
    aws_security_group.x-sgr-ec1-web-app.id
  ]

  key_name = aws_key_pair.runner.key_name

  user_data = <<EOF
#!/bin/bash
sudo yum update
sudo yum install -y nginx
sudo sh -c "hostname > /usr/share/nginx/html/index.html"
sudo systemctl enable --now nginx
EOF

  root_block_device {
    volume_size = 15
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
  }

  tags = {
    Name = "x-ec2-ec1-1c-backend"
    Mode = "terraform"
  }
}

resource "aws_instance" "x-ec2-ec1-1c-backend-1" {
  ami = "ami-0c8db01b2e8e5298d"
  instance_type = "t3.small"

  availability_zone = "eu-central-1c"
  subnet_id = aws_subnet.x-sbn-1c-private.id
  security_groups = [ 
    aws_security_group.x-sgr-ec1-essential.id,
    aws_security_group.x-sgr-ec1-web-app.id
  ]

  key_name = aws_key_pair.runner.key_name

  user_data = <<EOF
#!/bin/bash
sudo yum update
sudo yum install -y nginx
sudo sh -c "hostname > /usr/share/nginx/html/index.html"
sudo systemctl enable --now nginx
EOF

  root_block_device {
    volume_size = 15
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
  }

  tags = {
    Name = "x-ec2-ec1-1c-backend"
    Mode = "terraform"
  }
}

// Front End

resource "aws_instance" "x-ec2-ec1-1a-frontend-0" {
  ami = "ami-0c8db01b2e8e5298d"
  instance_type = "t3.small"

  availability_zone = "eu-central-1a"
  subnet_id = aws_subnet.x-sbn-1a-private.id
  security_groups = [ 
    aws_security_group.x-sgr-ec1-essential.id,
    aws_security_group.x-sgr-ec1-web-app.id
  ]

  key_name = aws_key_pair.runner.key_name

  user_data = <<EOF
#!/bin/bash
sudo yum update
sudo yum install -y nginx
sudo systemctl enable --now nginx
EOF

  root_block_device {
    volume_size = 15
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
  }

  tags = {
    Name = "x-ec2-ec1-1a-frontend"
    Mode = "terraform"
  }
}

resource "aws_instance" "x-ec2-ec1-1a-frontend-1" {
  ami = "ami-0c8db01b2e8e5298d"
  instance_type = "t3.small"

  availability_zone = "eu-central-1a"
  subnet_id = aws_subnet.x-sbn-1a-private.id
  security_groups = [ 
    aws_security_group.x-sgr-ec1-essential.id,
    aws_security_group.x-sgr-ec1-web-app.id
  ]

  key_name = aws_key_pair.runner.key_name

  user_data = <<EOF
#!/bin/bash
sudo yum update
sudo yum install -y nginx
sudo systemctl enable --now nginx
EOF

  root_block_device {
    volume_size = 15
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
  }

  tags = {
    Name = "x-ec2-ec1-1a-frontend"
    Mode = "terraform"
  }
}

resource "aws_instance" "x-ec2-ec1-1b-frontend" {
  ami = "ami-0c8db01b2e8e5298d"
  instance_type = "t3.small"

  availability_zone = "eu-central-1b"
  subnet_id = aws_subnet.x-sbn-1b-private.id
  security_groups = [ 
    aws_security_group.x-sgr-ec1-essential.id,
    aws_security_group.x-sgr-ec1-web-app.id
  ]

  key_name = aws_key_pair.runner.key_name

  user_data = <<EOF
#!/bin/bash
sudo yum update
sudo yum install -y nginx
sudo systemctl enable --now nginx
EOF

  root_block_device {
    volume_size = 15
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
  }

  tags = {
    Name = "x-ec2-ec1-1b-frontend"
    Mode = "terraform"
  }
}