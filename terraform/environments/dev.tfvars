#============================ Variables for VPC Module =======================================================

#profile = "MyAWS"

#============================ Variables for VPC Module =======================================================
region = "us-east-1"
vpc-cidr = "10.0.0.0/16"
vpc-tag = 
    default = [
    {
        Name = var.vpc-tag-name
        Environment = var.vpc-tag-env
    }
]
subnet-pub-tags = ["pub-sub-1a","pub-sub-1b","pub-sub-1c"]
pub-subnet-azs = ["us-east-1a","us-east-1b","us-east-1c"]
subnet-pri-tags = ["pri-sub-1a","pri-sub-1b","pri-sub-1c"]
pri-subnet-azs = ["us-east-1d","us-east-1e","us-east-1f"]
igw-tag = "projectigw"
nat-tag = "projectnat"
public-rt-tag = "public-rt"
private-rt-tag = "private-rt"

#============================ Variables for SG Module =======================================================

myip = "50.66.177.15/32"
bastion-sg-tag = "bastion-tag"
web-sg-tag = "web-tag"
db-sg-tag = "db-tag"

#============================ Variables for EIP Module =======================================================

eip-tag = "eip-project-tag"

#============================ Variables for EC2 Module =======================================================

region = "us-east-1"
ec2-ami = {
    type = map

    default = {
        us-east-1 = "ami-083654bd07b5da81d"
        us-east-2 = "ami-074cce78125f09d61"
        us-west-1 = "ami-03ab7423a204da002"
        us-west-2 = "ami-013a129d325529d4d"
    }
}

instance-type = "t2.micro"

#============================ E  N  D =======================================================