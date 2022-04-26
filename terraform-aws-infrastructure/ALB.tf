# Create Application Load Balancer
resource "aws_alb" "application-load-balancer" {
    name = "my-application-load-balancer"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.alb-security-group.id]

    subnet_mapping {
      subnet_id = aws_subnet.public-subnet-1.id
    }

    subnet_mapping {
      subnet_id = aws_subnet.public-subnet-2.id
    }

    enable_deletion_protection = false
    
    tags = {
        Name = "application load balancer"
        Owner = "Avid Mansurov"
        Created_by = "Terraform"
    }
}

# Create Target Group
resource "aws_lb_target_group" "alb-target-group" {
    name = "my-web-servers"
    target_type = "instance"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.vpc.id

    health_check {
      healthy_threshold = 5
      interval = 30
      matcher = "200,302" # success code in AWS
      path = "/"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
}

# Create a Listener on Port 80 with Forward Action
resource "aws_alb_listener" "alb-listener-no-ssl-certificate" {
    load_balancer_arn = aws_alb.application-load-balancer.arn
    port = "80"
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.alb-target-group.arn
    }
}

resource "aws_lb_target_group_attachment" "ec2_alb_attach" {
  target_group_arn = aws_lb_target_group.alb-target-group.arn
  target_id = aws_instance.linux_amazon.id
}

# # Create a Listener on Port 80 with Redirect Action
# resource "aws_alb_listener" "alb-listener-no-ssl-certificate" {
#     load_balancer_arn = aws_lb.application-load-balancer.arn
#     port = "80"
#     protocol = "HTTP"

#     default_action {
#       type = "redirect"

#       redirect {
#         host = "#{host}"
#         path = "/#{path}"
#         port = "443"
#         protocol = "HTTPS"
#         status_code = "HTTP_301"
#       }
#     }
# }

# # Create a Listener on Port 443 with Forward Action
# resource "aws_lb_listener" "alb-listener-no-ssl-certificate" {
#     load_balancer_arn = aws_lb.application-load-balancer.id
#     port = "443"
#     protocol = "HTTPS"
#     ssl_policy = "ELBSecurityPolicy-2016-08"
#     certificate_arn = "${var.ssl-certificate-arn}"

#     default_action {
#       type = "forward"
#     }
# }









