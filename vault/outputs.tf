output "hcp_vault_private_endpoint_url" {
  description = "The private endpoint URL of the HCP Vault cluster."
  value       = hcp_vault_cluster.vault.vault_private_endpoint_url
}

output "hcp_vault_public_endpoint_url" {
  description = "The public endpoint URL of the HCP Vault cluster."
  value       = hcp_vault_cluster.vault.vault_public_endpoint_url
}

output "hcp_vault_cluster_id" {
  description = "The cluster id of the HCP Vault cluster."
  value       = hcp_vault_cluster.vault.cluster_id
}


