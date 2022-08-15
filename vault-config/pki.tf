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
  issuing_certificates    = ["${data.terraform_remote_state.vault.outputs.hcp_vault_private_endpoint_url}/v1/${vault_mount.pki_root.path}/ca"]
  crl_distribution_points = ["${data.terraform_remote_state.vault.outputs.hcp_vault_private_endpoint_url}/v1/${vault_mount.pki_root.path}/crl"]
}

resource "vault_mount" "pki_int" {
  path = "pki/int"
  type = "pki"

  # 1 day
  default_lease_ttl_seconds = 60 * 60 * 24

  # 1 year
  max_lease_ttl_seconds = 60 * 60 * 24 * 365
}

# Generate the Root CA cert, sign it, set it
resource "vault_pki_secret_backend_config_urls" "pki_int_config_urls" {
  backend                 = vault_mount.pki_int.path
  issuing_certificates    = ["${data.terraform_remote_state.vault.outputs.hcp_vault_private_endpoint_url}/v1/${vault_mount.pki_int.path}/ca"]
  crl_distribution_points = ["${data.terraform_remote_state.vault.outputs.hcp_vault_private_endpoint_url}/v1/${vault_mount.pki_int.path}/crl"]
}

resource "vault_pki_secret_backend_root_cert" "pki_root_cert" {
  depends_on = [vault_mount.pki_root]

  backend = vault_mount.pki_root.path

  type        = "internal"
  common_name = "Boundary Lab Root CA"
  ttl         = 60 * 60 * 24 * 365 * 10
}

## Generate the cert request, sign it, set it
resource "vault_pki_secret_backend_intermediate_cert_request" "pki_int" {
  depends_on = [vault_mount.pki_int]

  backend = vault_mount.pki_int.path

  type        = "internal"
  common_name = "Boundary Lab Intermediate CA"
}

resource "vault_pki_secret_backend_root_sign_intermediate" "pki_root_int" {
  depends_on = [vault_pki_secret_backend_intermediate_cert_request.pki_int]

  backend = vault_mount.pki_root.path

  csr         = vault_pki_secret_backend_intermediate_cert_request.pki_int.csr
  common_name = "Boundary Lab Intermediate CA"
  format      = "pem_bundle"
  ttl         = 60 * 60 * 24 * 365
}

resource "vault_pki_secret_backend_intermediate_set_signed" "pki_int" {
  backend = vault_mount.pki_int.path

  certificate = vault_pki_secret_backend_root_sign_intermediate.pki_root_int.certificate
}
