resource "aws_route_table" "public-rt" {
    vpc_id = aws_vpc.k8s-vpc.id

    tags = {
        Name = "public-rt"
    }
}

resource "aws_route_table_association" "public-rt-1" {
    subnet_id      = aws_subnet.public-subnet-1.id
    route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "public-rt-2" {
    subnet_id      = aws_subnet.public-subnet-2.id
    route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table" "private-rt" {
    vpc_id = aws_vpc.k8s-vpc.id

    tags = {
        Name = "private-rt"
    }
}

resource "aws_route_table_association" "private-rt-1" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "private-rt-2" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-rt.id
}