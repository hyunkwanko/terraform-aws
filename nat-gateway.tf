resource "aws_nat_gateway" "nat-gateway" {
    allocation_id = aws_eip.nat-ip.id

    subnet_id = aws_subnet.public-subnet-1.id

    tags = {
        Name = "nat-gateway"
    }
}

resource "aws_route" "private-rt-nat" {
    route_table_id              = aws_route_table.private-rt.id
    destination_cidr_block      = "0.0.0.0/0"
    nat_gateway_id              = aws_nat_gateway.nat-gateway.id
}