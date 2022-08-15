# adapted from https://gist.github.com/lucymhdavies/bbe493ce4c4c21f02c55a8cb00cc9d62
resource "vault_mount" "pki_root" {
  path = "pki/root"
  type = "pki"

  # 1 day
  default_lease_ttl_seconds = 60 * 60 * 24

  # 5 years
  max_lease_ttl_seconds = 60 * 60 * 24 * 365 * 5
}

resource "vault_pki_secret_backend_config_urls" "pki_root_config_urls" {
  backend                 = vault_mount.pki_root.path
  issuing_certificates    = ["${data.terraform_remote_state.vault.hcp_vault_private_endpoint_url}/v1/${vault_mount.pki_root.path}/ca"]
  crl_distribution_points = ["${data.terraform_remote_state.vault.hcp_vault_private_endpoint_url}/v1/${vault_mount.pki_root.path}/crl"]
}
