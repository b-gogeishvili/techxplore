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
sudo yum install -y docker

sudo echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDzK98ti/yyZS2pKi15HspX+EKlngZUkzkqseeUa4tOn odin@Zen" >> /home/ec2-user/.ssh/authorized_keys

sudo systemctl enable --now docker
sudo usermod -aG docker $USER

# Download the binary for your system
sudo curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64

# Give it permission to execute
sudo chmod +x /usr/local/bin/gitlab-runner

# Create a GitLab Runner user
sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash

# Install and run as a service
sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
sudo gitlab-runner start
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
sudo yum install -y ansible

sudo echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDzK98ti/yyZS2pKi15HspX+EKlngZUkzkqseeUa4tOn odin@Zen" >> /home/ec2-user/.ssh/authorized_keys
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
sudo yum install -y docker

sudo echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDzK98ti/yyZS2pKi15HspX+EKlngZUkzkqseeUa4tOn odin@Zen" >> /home/ec2-user/.ssh/authorized_keys

sudo systemctl enable --now docker
sudo usermod -aG docker $USER
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
sudo yum install -y docker

sudo echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDzK98ti/yyZS2pKi15HspX+EKlngZUkzkqseeUa4tOn odin@Zen" >> /home/ec2-user/.ssh/authorized_keys

sudo systemctl enable --now docker
sudo usermod -aG docker $USER
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
sudo yum install -y docker

sudo echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDzK98ti/yyZS2pKi15HspX+EKlngZUkzkqseeUa4tOn odin@Zen" >> /home/ec2-user/.ssh/authorized_keys

sudo systemctl enable --now docker
sudo usermod -aG docker $USER
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
sudo yum install -y docker

sudo echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDzK98ti/yyZS2pKi15HspX+EKlngZUkzkqseeUa4tOn odin@Zen" >> /home/ec2-user/.ssh/authorized_keys

sudo systemctl enable --now docker
sudo usermod -aG docker $USER
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
sudo yum install -y docker

sudo echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDzK98ti/yyZS2pKi15HspX+EKlngZUkzkqseeUa4tOn odin@Zen" >> /home/ec2-user/.ssh/authorized_keys

sudo systemctl enable --now docker
sudo usermod -aG docker $USER
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
sudo yum install -y docker

sudo echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDzK98ti/yyZS2pKi15HspX+EKlngZUkzkqseeUa4tOn odin@Zen" >> /home/ec2-user/.ssh/authorized_keys

sudo systemctl enable --now docker
sudo usermod -aG docker $USER
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