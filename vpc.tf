resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "project-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "3tier-igw"
  }
}

resource "aws_subnet" "public_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-az1"
  }
}
resource "aws_subnet" "public_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-az2"
  }
}

resource "aws_subnet" "web_az1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags = { Name = "web-az1" }
}

resource "aws_subnet" "app_az1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1a"

  tags = { Name = "app-az1" }
}

resource "aws_subnet" "db_az1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1a"

  tags = { Name = "db-az1" }
}

resource "aws_subnet" "web_az2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-east-1b"

  tags = { Name = "web-az2" }
}

resource "aws_subnet" "app_az2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.7.0/24"
  availability_zone = "us-east-1b"

  tags = { Name = "app-az2" }
}

resource "aws_subnet" "db_az2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.8.0/24"
  availability_zone = "us-east-1b"

  tags = { Name = "db-az2" }
}

resource "aws_eip" "nat_eip_az1" {
  domain = "vpc"
}

resource "aws_eip" "nat_eip_az2" {
  domain = "vpc"
}

# NAT AZ-1
resource "aws_nat_gateway" "nat_az1" {
  allocation_id = aws_eip.nat_eip_az1.id
  subnet_id     = aws_subnet.public_az1.id

  tags = { Name = "nat-az1" }
}

# NAT AZ-2
resource "aws_nat_gateway" "nat_az2" {
  allocation_id = aws_eip.nat_eip_az2.id
  subnet_id     = aws_subnet.public_az2.id

  tags = { Name = "nat-az2" }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
resource "aws_route_table_association" "public_az1_assoc" {
  subnet_id      = aws_subnet.public_az1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_az2_assoc" {
  subnet_id      = aws_subnet.public_az2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt_az1" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_az1.id
  }
}
resource "aws_route_table_association" "web_az1_assoc" {
  subnet_id      = aws_subnet.web_az1.id
  route_table_id = aws_route_table.private_rt_az1.id
}

resource "aws_route_table_association" "app_az1_assoc" {
  subnet_id      = aws_subnet.app_az1.id
  route_table_id = aws_route_table.private_rt_az1.id
}

resource "aws_route_table_association" "db_az1_assoc" {
  subnet_id      = aws_subnet.db_az1.id
  route_table_id = aws_route_table.private_rt_az1.id
}

resource "aws_route_table" "private_rt_az2" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_az2.id
  }
}
resource "aws_route_table_association" "web_az2_assoc" {
  subnet_id      = aws_subnet.web_az2.id
  route_table_id = aws_route_table.private_rt_az2.id
}

resource "aws_route_table_association" "app_az2_assoc" {
  subnet_id      = aws_subnet.app_az2.id
  route_table_id = aws_route_table.private_rt_az2.id
}

resource "aws_route_table_association" "db_az2_assoc" {
  subnet_id      = aws_subnet.db_az2.id
  route_table_id = aws_route_table.private_rt_az2.id
}