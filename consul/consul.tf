resource "hcp_consul_cluster" "consul" {
  hvn_id          = data.terraform_remote_state.global.outputs.hcp_hvn_aws_use1_id
  cluster_id      = var.cluster_id
  tier            = var.tier
  public_endpoint = var.public_endpoint
}
