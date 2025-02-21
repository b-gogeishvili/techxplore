resource "aws_lb" "x-alb-ec1" {
  name = "x-alb-ec1-front"
  internal = false
  load_balancer_type = "application"
  security_groups = [ aws_security_group.x-sgr-ec1-load-balancer.id ]
  subnets = [ for subnet in aws_subnet.public : subnet.id ]

  enable_deletion_protection = false

  tags = {
    Name = "x-alb-ec1"
    Mode = "terraform"
  }
}

resource "aws_lb_listener" "x-alb-ec1-listener" {
  load_balancer_arn = aws_lb.x-alb-ec1.arn
  port = "80"
  protocol = "HTTP"
 
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404 Not Found :("
      status_code  = "404"
    }
  }
}

// Front

resource "aws_lb_listener_rule" "front_listener" {
  listener_arn = aws_lb_listener.front_end.arn
  priority     = 100

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.x-tg-ec1-front.arn
  }

  condition {
    host_header {
      values = ["splitnpay.devops-ninja.me"]
    }
  }
}

resource "aws_lb_target_group" "x-tg-ec1-front" {
  name = "x-tg-ec1-front"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.x-vpc-ec1.id

  health_check {
    path = "/"
    interval = 30
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "x-tg-ec1-front"
    Mode = "terraform"
  }
}

resource "aws_lb_target_group_attachment" "front_attachment" {
  target_group_arn = aws_lb_target_group.x-tg-ec1-front.arn
  target_id = aws_instance.x-ec2-ec1-1a-frontend-0
  port = 80
}

resource "aws_lb_target_group_attachment" "front_attachment" {
  target_group_arn = aws_lb_target_group.x-tg-ec1-front.arn
  target_id = aws_instance.x-ec2-ec1-1a-frontend-1
  port = 80
}

resource "aws_lb_target_group_attachment" "front_attachment" {
  target_group_arn = aws_lb_target_group.x-tg-ec1-front.arn
  target_id = aws_instance.x-ec2-ec1-1b-frontend
  port = 80
}

// Back

resource "aws_lb_listener_rule" "back_listener" {
  listener_arn = aws_lb_listener.front_end.arn
  priority     = 200

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.x-tg-ec1-back.arn
  }

  condition {
    host_header {
      values = ["api.splitnpay.devops-ninja.me"]
    }
  }
}

resource "aws_lb_target_group" "x-tg-ec1-back" {
  name = "x-tg-ec1-back"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.x-vpc-ec1.id

  health_check {
    path = "/"
    interval = 30
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "x-tg-ec1-back"
    Mode = "terraform"
  }
}

resource "aws_lb_target_group_attachment" "back_attachment" {
  target_group_arn = aws_lb_target_group.x-tg-ec1-back.arn
  target_id = aws_instance.x-ec2-ec1-1a-backend-0
  port = 80
}

resource "aws_lb_target_group_attachment" "back_attachment" {
  target_group_arn = aws_lb_target_group.x-tg-ec1-back.arn
  target_id = aws_instance.x-ec2-ec1-1a-backend-1
  port = 80
}

resource "aws_lb_target_group_attachment" "back_attachment" {
  target_group_arn = aws_lb_target_group.x-tg-ec1-back.arn
  target_id = aws_instance.x-ec2-ec1-1b-backend
  port = 80
}