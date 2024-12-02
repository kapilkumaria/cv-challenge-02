provider "aws" {
    profile = "myAWS"
}

module "network" {
    source = "./modules/network"
    vpc-cidr = var.vpc-cidr
    vpc-tag = var.vpc-tag
    subnet-pub-tags = var.subnet-pub-tags
    subnet-pri-tags = var.subnet-pri-tags
    pub-subnet-azs = var.pub-subnet-azs
    pri-subnet-azs = var.pri-subnet-azs
    igw-tag = var.igw-tag
    nat-tag = var.nat-tag
    public-rt-tag = var.public-rt-tag
    private-rt-tag = var.private-rt-tag
    eip-id = module.network.eip-id   
    pub-sub-cidr-block = var.pub-sub-cidr-block
    pri-sub-cidr-block = var.pri-sub-cidr-block
}




