resource "aws_vpc" "my_assg_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "${var.vpc_name}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_assg_vpc.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}


resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.my_assg_vpc.id
  cidr_block = var.public_cidr
  availability_zone = var.azs[0]
  map_public_ip_on_launch = true

tags = {
    Name = "${var.vpc_name}-public-subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.my_assg_vpc.id
  cidr_block = var.private_cidr
  availability_zone = var.azs[1]
tags = {
    Name = "${var.vpc_name}-private-subnet"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_assg_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.vpc_name}-public_rt"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.my_assg_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.my_assg_vpc_nat.id
  }

  tags = {
    Name = "${var.vpc_name}-private_rt"
  }
}

resource "aws_route_table_association" "rt_pub_assg" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "rt_pri_assg" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "my_assg_vpc_nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id


  tags = {
    Name = "${var.vpc_name}-natgw"
  }

  depends_on = [aws_internet_gateway.igw]
}
