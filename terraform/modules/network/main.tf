#################################### Creating VPC ############################

resource "aws_vpc" "cv02vpc" {
    cidr_block = var.vpc-cidr
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"

    tags = {
        Name = var.vpc-tag
    }
} 

#################################### Creating Subnets ############################

resource "aws_subnet" "subnets-pub" {
    count = length(var.subnet-pub-tags)
    vpc_id = aws_vpc.cv02vpc.id
    cidr_block = var.pub-sub-cidr-block[count.index]
    availability_zone = var.pub-subnet-azs[count.index]
    map_public_ip_on_launch = true
    
    tags = {
        Name = var.subnet-pub-tags[count.index]
    }
}

resource "aws_subnet" "subnets-pri" {
    count = length(var.subnet-pri-tags)
    vpc_id = aws_vpc.cv02vpc.id
    cidr_block = var.pri-sub-cidr-block[count.index]
    availability_zone = var.pri-subnet-azs[count.index]
    map_public_ip_on_launch = false

    tags = {
        Name = var.subnet-pri-tags[count.index]
    }
}

#################################### Creating Internet Gateway ############################

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.cv02vpc.id

    tags = {
        Name = var.igw-tag
    }
}

#################################### Creating NAT Gateway ############################

resource "aws_nat_gateway" "nat" {
    allocation_id = var.eip-id
    subnet_id = aws_subnet.subnets-pub[0].id

    tags = {
        Name = var.nat-tag
    }
}

#################################### Creating Public and Private Route Tables ############################

resource "aws_route_table" "rta-pub" {
    vpc_id = aws_vpc.cv02vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = var.public-rt-tag
    }
}

resource "aws_route_table" "rta-pri" {
    vpc_id = aws_vpc.cv02vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat.id
    }

    tags = {
        Name = var.private-rt-tag
    }
}

resource "aws_route_table_association" "pub-rt-association" {
    count = length(var.subnet-pub-tags)
    subnet_id = aws_subnet.subnets-pub[count.index].id
    route_table_id = aws_route_table.rta-pub.id
}

resource "aws_route_table_association" "pri-rt-association" {
    count = length(var.subnet-pri-tags)
    subnet_id = aws_subnet.subnets-pri[count.index].id
    route_table_id = aws_route_table.rta-pri.id
}

#################################### End #######################################################