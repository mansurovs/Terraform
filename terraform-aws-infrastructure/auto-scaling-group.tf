# Import AMI
data "aws_ami" "latest_amazon_linux" {
    owners = ["137112412989"]
    most_recent = true
    filter {
        name = "name"
        values = ["amzn2-ami-hvm-*"]
    }
}

# Create Launch Configuration
resource "aws_launch_configuration" "bastion-host-lc" {
    #name = "bastion-host-launch-configuration"
    name_prefix = "bastion-host-launch-configuration-" 
    image_id = data.aws_ami.latest_amazon_linux.id
    instance_type = "t2.micro"
    security_groups = [aws_security_group.ssh-security-group.id]
    key_name = "new"

    lifecycle {
      create_before_destroy = true
    } 
}

resource "aws_autoscaling_group" "bastion-host-ASG" {
    name = "ASG-${aws_launch_configuration.bastion-host-lc.name}"
    launch_configuration = aws_launch_configuration.bastion-host-lc.name
    min_size = 1
    max_size = 1
    min_elb_capacity = 1
    health_check_type = "ELB"
    vpc_zone_identifier = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]

    dynamic "tag" {
        for_each = { 
            Name = "Bastion Host in ASG"
            Owner = "Avid Mansurov"
            Created_by = "Terraform"
        }
        content {
          key = tag.key 
          value = tag.value
          propagate_at_launch = true
        }
    }

    lifecycle {
      create_before_destroy = true
    }  
}