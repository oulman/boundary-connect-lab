resource "hcp_vault_cluster" "vault" {
  hvn_id          = data.terraform_remote_state.global.outputs.hcp_hvn_aws_use1_hvn_id
  cluster_id      = var.cluster_id
  tier            = var.tier
  public_endpoint = var.public_endpoint
}
