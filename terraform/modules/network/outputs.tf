# ===================== VPC OUTPUTS =========================================== 

output "vpc-id" {
    value = aws_vpc.cv02vpc.id
}

output "vpc-cidr" {
    value = aws_vpc.cv02vpc.cidr_block
}

output "vpc-tag" {
    value = aws_vpc.cv02vpc.tags
}

output "vpc-default-rt-id" {
value = aws_vpc.cv02vpc.default_route_table_id
}

# ===================== SUBNETS OUTPUTS ===========================================

output "subnets-pub-id" {
    value = aws_subnet.subnets-pub.*.id
}

output "subnets-pri-id" {
    value = aws_subnet.subnets-pri.*.id
}

output "subnets-pub-arn" {
    value = aws_subnet.subnets-pub.*.arn
}

output "subnets-pri-arn" {
    value = aws_subnet.subnets-pri.*.arn
}

output "public-1a" {
    value = aws_subnet.subnets-pub[0].id
}

output "public-1b" {
    value = aws_subnet.subnets-pub[1].id
}

# ===================== IGW OUTPUTS ===========================================

output "IGW-IDs" {
    value = aws_internet_gateway.igw.id
}

output "IGW-ARN" {
    value = aws_internet_gateway.igw.arn
}

output "IGW-TAGS" {
    value = aws_internet_gateway.igw.tags_all
}

# ===================== NAT OUTPUTS ===========================================

output "NAT-IDs" {
    value = aws_nat_gateway.nat.id
}

output "NAT-ALLOCATION-ID" {
    value = aws_nat_gateway.nat.connectivity_type
}

output "NAT-SUBNET-ID" {
    value = aws_nat_gateway.nat.subnet_id
}

output "NAT-TAGS" {
    value = aws_nat_gateway.nat.tags
}

output "NAT-PUBLIC_IP" {
    value = aws_nat_gateway.nat.public_ip
}

output "NAT-PRIVATE_IP" {
    value = aws_nat_gateway.nat.private_ip
}

# ===================== PUBLIC ROUTE TABLE OUTPUTS ===========================================

output "ROUTE-TABLE-PUB-ID" {
    value = aws_route_table.rta-pub.vpc_id
}

output "ROUTE-TABLE-PUB-ROUTE" {
    value = aws_route_table.rta-pub.route
}

output "ROUTE-TABLE-PUB-TAGS" {
    value = aws_route_table.rta-pub.tags
}

# ===================== PRIVATE ROUTE TABLE OUTPUTS ===========================================

output "ROUTE-TABLE-PRI-ID" {
    value = aws_route_table.rta-pri.vpc_id
}

output "ROUTE-TABLE-PRI-ROUTE" {
    value = aws_route_table.rta-pri.route
}

output "ROUTE-TABLE-PRI-TAGS" {
    value = aws_route_table.rta-pri.tags
}

# ===================== END ===================================================================