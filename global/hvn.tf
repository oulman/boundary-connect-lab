
data "aws_arn" "vpc" {
  arn = module.vpc.vpc_arn
}

resource "hcp_hvn" "aws_use1_hvn" {
  hvn_id         = var.hcp_hvn_id
  cloud_provider = var.hcp_cloud_provider
  region         = data.aws_arn.vpc.region
}

resource "hcp_aws_network_peering" "hcp_use1_vpc" {
  hvn_id          = hcp_hvn.aws_use1_hvn.hvn_id
  peering_id      = var.hcp_hvn_peering_id
  peer_vpc_id     = module.vpc.vpc_id
  peer_account_id = module.vpc.vpc_owner_id
  peer_vpc_region = data.aws_arn.vpc.region
}
