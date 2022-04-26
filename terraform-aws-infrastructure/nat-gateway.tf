# Allocate EIP Address
resource "aws_eip" "eip-for-nat-gateway-1" {
    vpc = true

    tags = {
      Name = "EIP 1"
    }
}


resource "aws_eip" "eip-for-nat-gateway-2" {
    vpc = true

    tags = {
      Name = "EIP 2"
    }
}



resource "aws_nat_gateway" "nat-gateway-1" {
    allocation_id = aws_eip.eip-for-nat-gateway-1.id
    subnet_id = aws_subnet.public-subnet-1.id

    tags = {
      Name = "Nat-Gateway Public Subnet 1"
    }
}


resource "aws_nat_gateway" "nat-gateway-2" {
    allocation_id = aws_eip.eip-for-nat-gateway-2.id
    subnet_id = aws_subnet.public-subnet-2.id

    tags = {
      Name = "Nat-Gateway Public Subnet 2"
    }
}

resource "aws_route_table" "private-route-table-1" {
    vpc_id = aws_vpc.vpc.id
  
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat-gateway-1.id
    }

    tags = {
      Name = "Private Subnet Route Table 1"
    }
}


resource "aws_route_table_association" "private-subnet-1-route-table-association" {
    subnet_id = aws_subnet.private-subnet-1.id
    route_table_id = aws_route_table.private-route-table-1.id
}


resource "aws_route_table" "private-route-table-2" {
    vpc_id = aws_vpc.vpc.id
  
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat-gateway-2.id
    }

    tags = {
      Name = "Private Subnet Route Table 2"
    }
}


resource "aws_route_table_association" "private-subnet-2-route-table-association" {
    subnet_id = aws_subnet.private-subnet-2.id
    route_table_id = aws_route_table.private-route-table-2.id
}



resource "aws_route_table" "private-route-table-3" {
    vpc_id = aws_vpc.vpc.id

    tags = {
      Name = "Private Database Route Table"
    }
}


resource "aws_route_table_association" "private-subnet-3-route-table-association" {
    subnet_id = aws_subnet.private-subnet-3.id
    route_table_id = aws_route_table.private-route-table-3.id
}


resource "aws_route_table_association" "private-subnet-4-route-table-association" {
    subnet_id = aws_subnet.private-subnet-4.id
    route_table_id = aws_route_table.private-route-table-3.id
}