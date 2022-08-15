resource "vault_mount" "nomad" {
  path = "secret/nomad"
  type = "kv-v2"
}

resource "vault_mount" "service_a" {
  path = "secret/service-a"
  type = "kv-v2"
}

resource "vault_mount" "service_b" {
  path = "secret/service-b"
  type = "kv-v2"
}
