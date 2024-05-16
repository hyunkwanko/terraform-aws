resource "aws_subnet" "public-subnet-1" {
    vpc_id = aws_vpc.k8s-vpc.id
    cidr_block = "10.1.0.0/24"

    availability_zone = "ap-northeast-2a"

    tags = {
        Name = "public-subnet-1"
    }
}

resource "aws_subnet" "public-subnet-2" {
    vpc_id = aws_vpc.k8s-vpc.id
    cidr_block = "10.1.1.0/24"

    availability_zone = "ap-northeast-2b"

    tags = {
        Name = "public-subnet-2"
    }
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id     = aws_vpc.k8s-vpc.id
  cidr_block = "10.1.2.0/24"

  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id     = aws_vpc.k8s-vpc.id
  cidr_block = "10.1.3.0/24"

  availability_zone = "ap-northeast-2b"

  tags = {
    Name = "private-subnet-2"
  }
}