module "vpc" {
  source             = "./modules/vpc"
  vpc_name           = "my-vpc"
  vpc_cidr = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
}

module "ec2" {
  source           = "./modules/ec2"
  #ami_id           = "ami-0866a3c8686eaeeba" 
  instance_type    = "t2.micro"
  subnet_ids       = module.vpc.public_subnet_ids
  security_group_id = aws_security_group.main.id
}

module "alb" {
  source             = "./modules/alb"
  lb_name            = "my-alb"
  target_group_name  = "my-target-group"
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_id  = aws_security_group.main.id
  ec2_ids            = module.ec2.ec2_ids
}

resource "aws_security_group" "main" {
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "main-sg"
  }
}

