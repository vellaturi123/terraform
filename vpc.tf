

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/24"
  instance_tenancy = "default"
  enable_dns_support = true 
  enable_dns_hostnames =true
  
  tags = {
    Name = "public"
  }
}


 resource "aws_internet_gateway" "IGW" {    # Creating Internet Gateway
    vpc_id =  aws_vpc.vpc.id               # vpc_id will be generated after we create VPC
 }

 resource "aws_subnet" "publicsubnet" {    # Creating Public Subnets
   vpc_id =  aws_vpc.vpc.id
   cidr_block = "${var.public_subnets}"
   
   tags = {
       Name = "public"
   }        
 }

 resource "aws_subnet" "privatesubnet" {    # Creating Private Subnets
   vpc_id =  aws_vpc.vpc.id
   cidr_block = "${var.private_subnets}"
   
   tags = {
       Name = "private"
   }        
 }

 
 resource "aws_route_table" "PublicRT" {    # Creating RT for Public Subnet
    vpc_id =  aws_vpc.vpc.id
         route {
    cidr_block = "0.0.0.0/0"               # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.IGW.id
     }
 }
 
 resource "aws_route_table" "PrivateRT" {    # Creating RT for Private Subnet
   vpc_id = aws_vpc.vpc.id
   route {
   cidr_block = "0.0.0.0/0"             # Traffic from Private Subnet reaches Internet via NAT Gateway
   nat_gateway_id = aws_nat_gateway.NATgw.id
   }
 }
 
 resource "aws_route_table_association" "PublicRTassociation" {
    subnet_id = aws_subnet.publicsubnet.id
    route_table_id = aws_route_table.PublicRT.id
 }
 
 resource "aws_route_table_association" "PrivateRTassociation" {
    subnet_id = aws_subnet.privatesubnet.id
    route_table_id = aws_route_table.PrivateRT.id
 }
 resource "aws_eip" "nateIP" {
   vpc   = true
 }
 
  resource "aws_nat_gateway" "NATgw" {
   allocation_id = aws_eip.nateIP.id
   subnet_id = aws_subnet.publicsubnet.id
 }

 resource "aws_security_group" "security_group" {
  name          = "sampleappsg-123"
  description   = "Inbound and outbound traffic for sampleapp service"
  vpc_id        = aws_vpc.vpc.id

  ingress {
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
    cidr_blocks = ["10.0.0.0/8"]
  
  }
  egress {
    from_port = 80
    protocol  = "-1"
    to_port   = 80
    cidr_blocks = ["10.0.0.0/8"]
  
  }

  tags = {
    Name = "Sample App Security Group"
  }
}