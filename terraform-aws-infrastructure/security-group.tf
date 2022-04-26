# Create Security Group for the Bastion Host aka Jump Box
resource "aws_security_group" "ssh-security-group" {
    name = "SSH Access for Bastion Host"
    description = "Enable SSH access on Port 22"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "SSH Access"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.ssh-location}"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      name = "SSH Security Group"
    }
}


resource "aws_security_group" "rdp-security-group" {
    name = "RDP Access for Bastion Host"
    description = "Enable RDP access on Port 3389"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "RDP Access"
        from_port = 3389
        to_port = 3389
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      name = "RDP Security Group"
    }
}


# Create Security Group for the Application Load Balancer
resource "aws_security_group" "alb-security-group" {
    name = "ALB Security Group"
    description = "Enable HTTP/HTTPS access on Port 80/443"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "HTTP Access"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTPS Access"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1" #allow all traffic
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      name = "Application Load Balancer Security Group"
    }
}

resource "aws_security_group" "my_webserver" {
  name        = "Dynamic Security Group"
  description = "Allow HTTP/S via ALB and SSH via Bastion Host"
  vpc_id      = aws_vpc.vpc.id

  dynamic "ingress" {
      for_each      = ["80", "443"]
    content{
        from_port   = ingress.value
        to_port     = ingress.value
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        # security_groups = ["${aws_security_group.alb-security-group.id}"]
      }
}

    ingress {
        description = "SSH Access"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        # security_security_groups = ["${aws_security_group.ssh-security-group.id}"] 
    }


    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
    tags = {
        Name = "Dynamic Security Group"
        Owner = "Avid Mansurov"
        Created_by = "Terraform"
    }
}


/* # Create Security Group for the Database
resource "aws_security_group" "database-security-group" {
    name = "Database Security Group"
    description = "Enable MySQL Aurora access on Port 3306"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "MySQL/Aurora Access"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = ["${aws_security_group.webserver-security-group.id}"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      name = "Database Security Group"
    }
} */