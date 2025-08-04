module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24"]
  availability_zones  = ["us-west-1a"]
}

module "security_group" {
  source            = "./modules/security_group"
  vpc_id            = module.vpc.vpc_id
  ssh_allowed_ip    = "70.168.153.114/32"
  http_access_cidr  = "0.0.0.0/0"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]  # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

module "ec2" {
  source             = "./modules/ec2"
  ami_id             = data.aws_ami.ubuntu.id
  instance_type      = "t3.micro"
  subnet_id          = module.vpc.public_subnet_ids[0]
  security_group_ids = [module.security_group.sg_id]
  key_name           = "single-tier-key"
}