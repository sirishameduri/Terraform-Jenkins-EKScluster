#VPC
data "aws_availability_zones" "azs" {}
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins-vpc"
  cidr = var.vpc_cidr

  azs            = data.aws_availability_zones.azs.names
  public_subnets = var.public_subnets

  enable_dns_hostnames = true

  tags = {
    Name        = "jenkins-vpc"
    Terraform   = "true"
    Environment = "dev"
  }
  public_subnet_tags = {
    Name =  "jenkins-subnet"
  }
}
#security group module
module "sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "jenkins-securitygroup"
  description = "Jenkins-securitygroup"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "HTTP"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH"
      cidr_blocks = "0.0.0.0/0"
    
  
    },
    
  ]

  egress_with_cidr_blocks = [
    {
      from_port = 0
      to_port = 0
      protocol="-1"
      cidr_blocks="0.0.0.0/0"
    }
    
  ]
  tags = {
    Name = "jenkins-sg"
  }
      
    }
# ec2 instance
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type          = var.ec2_instance
  key_name               = "ec2instance"
  monitoring             = true
  vpc_security_group_ids = [module.sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  user_data = file("jenkins-installer.sh")
  availability_zone      = data.aws_availability_zones.azs.names[0]
  tags = {
    Name = "jenkins-ec2"
    Terraform   = "true"
    Environment = "dev"
  }
}