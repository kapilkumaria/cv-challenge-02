#============================ Variables for AWS Authentication ===============================================

#variable "profile" {
#    default = "MyAWS"
#}

#============================ Variables for VPC Module =======================================================

variable "vpc-cidr" {
    default = "10.0.0.0/16"
}

variable "pub-sub-cidr-block" {
    default = ["10.0.0.0/24","10.0.1.0/24","10.0.2.0/24"]
}

variable "pri-sub-cidr-block" {
    default = ["10.0.3.0/24","10.0.4.0/24","10.0.5.0/24"]
}


variable "subnet-pub-tags" {
    default = ["pub-sub-1a","pub-sub-1b","pub-sub-1c"]
}

variable "pub-subnet-azs" {
    default = ["us-east-1a","us-east-1b","us-east-1c"]
}

variable "subnet-pri-tags" {
    default = ["pri-sub-1a","pri-sub-1b","pri-sub-1c"]
}

variable "pri-subnet-azs" {
    default = ["us-east-1d","us-east-1e","us-east-1f"]
}

variable "igw-tag" {
    default = "projectigw"
}

variable "nat-tag" {
    default = "projectnat"
}

variable "public-rt-tag" {
    default = "public-rt"
}

variable "private-rt-tag" {
    default = "private-rt"
}

variable "vpc-tag" {
    default = "my-vpc-tag"
}

#============================ Variables for SG Module =======================================================

variable "myip" {
    default = "66.222.146.176/32"
}

variable "bastion-sg-tag" {
    default = "bastion-tag"
}

variable "web-sg-tag" {
    default = "web-tag"
}

variable "db-sg-tag" {
    default = "db-tag"
}

#============================ Variables for EIP Module =======================================================

variable "eip-tag" {
    default = "eip-project-tag"
}

#============================ Variables for EC2 Module =======================================================

variable "region" {
    default = "us-east-1"
}

variable "ec2-ami" {
    type = map

    default = {
        us-east-1 = "ami-083654bd07b5da81d"
        us-east-2 = "ami-074cce78125f09d61"
        us-west-1 = "ami-03ab7423a204da002"
        us-west-2 = "ami-013a129d325529d4d"
    }
}

variable "instance-type" {
    default = "t2.micro"
}

variable "instance-web-tags" {
    default = ["web-1a","web-1b"]
}

variable "instance-db-tags" {
    default = ["db-1a","db-1b"]
}

#============================ E  N  D =======================================================