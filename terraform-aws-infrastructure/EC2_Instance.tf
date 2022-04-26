# resource "aws_eip" "static_ip" {
#     instance = aws_instance.linux_amazon.id
# }

resource "aws_instance" "linux_amazon" {
    ami                     =       "ami-04c921614424b07cd"
    instance_type           =       "t3.micro"
    subnet_id               =       aws_subnet.private-subnet-1.id
    availability_zone       =       "eu-central-1a"
    vpc_security_group_ids  =       [aws_security_group.my_webserver.id]
    key_name                =       "new"
    user_data               =       templatefile("user_data.sh.tpl", {
        f_name = "Avid"
        l_name = "Mansurov"
    })

    tags = {
        Name = "Amazon Linux Instance"
        Owner = "Avid Mansurov"
        Created_by = "Terraform"

    }

    depends_on = [

    aws_nat_gateway.nat-gateway-1
    ]

    lifecycle {
     create_before_destroy = true
    }
}

resource "aws_instance" "windows_server_2019_1" {
    ami                     =       "ami-014c4bcfe3cae98f0"
    instance_type           =       "t3.micro"
    subnet_id               =       aws_subnet.public-subnet-1.id
    availability_zone       =       "eu-central-1a"
    vpc_security_group_ids  =       [aws_security_group.rdp-security-group.id]
    key_name                =       "new"


    tags = {
        Name = "Windows Server 2019 Instance_1"
        Owner = "Avid Mansurov"
        Created_by = "Terraform"

    }

    depends_on = [

    aws_nat_gateway.nat-gateway-1
    ]

    lifecycle {
     create_before_destroy = true
    }
}

resource "aws_instance" "windows_server_2019_2" {
    ami                     =       "ami-014c4bcfe3cae98f0"
    instance_type           =       "t3.micro"
    subnet_id               =       aws_subnet.public-subnet-2.id
    availability_zone       =       "eu-central-1b"
    vpc_security_group_ids  =       [aws_security_group.rdp-security-group.id]
    key_name                =       "new"


    tags = {
        Name = "Windows Server 2019 Instance_2"
        Owner = "Avid Mansurov"
        Created_by = "Terraform"

    }

    depends_on = [

    aws_nat_gateway.nat-gateway-2
    ]

    lifecycle {
     create_before_destroy = true
    }
}

    # lifecycle {
    #     prevent_destroy = true
    # }

    # lifecycle {
    #     ignore_changes = ["ami", "user_data"]
    # }



