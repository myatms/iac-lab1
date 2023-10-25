
#VPC
resource "aws_vpc" "mylab_vpc" {
  cidr_block = "10.30.0.0/16"
  tags = {
    "Name" = "MyLabsVPC"
  }
}
#Subnet_1
resource "aws_subnet" "mylab_subnet_public" {
  vpc_id                  = aws_vpc.mylab_vpc.id
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = true
  cidr_block              = "10.30.1.0/24"
  tags = {
    "Name" = "Public_Subnet"
  }
}
#Subnet_2
resource "aws_subnet" "mylab_subnet_public_b" {
  vpc_id                  = aws_vpc.mylab_vpc.id
  availability_zone       = "ap-southeast-1b"
  map_public_ip_on_launch = true
  cidr_block              = "10.30.2.0/24"
  tags = {
    "Name" = "Public_Subnet_b"
  }
}



#IGW
resource "aws_internet_gateway" "mylab-igw" {
  vpc_id = aws_vpc.mylab_vpc.id
}
#Route_Table
resource "aws_route_table" "mylab_pub_rt" {
  vpc_id = aws_vpc.mylab_vpc.id
}
#Route in route table for internet access
resource "aws_route" "mylab_public_route" {
  route_table_id         = aws_route_table.mylab_pub_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.mylab-igw.id

}
#Subnet Association
resource "aws_route_table_association" "mylab-rt-associate" {
  route_table_id = aws_route_table.mylab_pub_rt.id
  subnet_id      = aws_subnet.mylab_subnet_public.id


}
#Security Group
resource "aws_security_group" "mylab_sg" {
  name        = "All-Traffic"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.mylab_vpc.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "All-traffic-sg"
  }
}