module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.12.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_dns_hostnames = var.vpc_enable_dns_hostnames

  tags = {
    Terraform   = "true"
    Environment = "lab"
  }
}

module "nat" {
  source = "int128/nat-instance/aws"

  name                        = "main"
  vpc_id                      = module.vpc.vpc_id
  public_subnet               = module.vpc.public_subnets[0]
  private_subnets_cidr_blocks = module.vpc.private_subnets_cidr_blocks
  private_route_table_ids     = module.vpc.private_route_table_ids
}

resource "aws_eip" "nat" {
  network_interface = module.nat.eni_id
  tags = {
    "Name" = "nat-instance-main"
  }
}
