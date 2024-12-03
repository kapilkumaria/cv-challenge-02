provider "aws" {
    profile = "myAWS"  
}

module "network" {
  source               = "./modules/network"
  vpc_cidr_block       = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
  enable_nat_gateway   = true
  nat_gateway_eip_allocation_ids = []
  tags                 = { Environment = "dev", Team = "compute" }
  environment          = "dev"
}

module "compute" {
  source               = "./modules/compute"
  vpc_id               = module.network.vpc_id
  subnet_id            = module.network.public_subnet_ids[0] # Choose the first public subnet
  ami_id               = "ami-0866a3c8686eaeeba"             # Replace with a valid AMI ID
  instance_type        = "t2.medium"
  key_name             = "devops1"                      # Replace with your SSH key name
  instance_count       = 1
  environment          = "dev"
  tags                 = { Environment = "dev", Team = "compute" }
}
