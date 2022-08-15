resource "vault_pki_secret_backend_role" "nomad_cluster_us-east-1" {
  backend            = vault_mount.pki_int.path
  name               = "nomad-cluster-us-east-1"
  ttl                = 345600
  key_type           = "rsa"
  key_bits           = 4096
  allow_bare_domains = true
  allowed_domains    = ["server.us-east-1.nomad", "client.us-east-1.nomad", "cli.us-east-1.nomad"]
  allow_subdomains   = false
  generate_lease     = false
  allow_ip_sans      = true
  allow_localhost    = true
  key_usage = [
    "DigitalSignature",
    "KeyAgreement",
    "KeyEncipherment"
  ]
  require_cn = false
}
