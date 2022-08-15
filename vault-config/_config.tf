terraform {
  backend "remote" {
    organization = "jamesoulman"

    workspaces {
      name = "boundary-connect-lab-vault-config"
    }
  }
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "3.8.2"
    }
  }
}

provider "vault" {
  address = data.terraform_remote_state.vault.hcp_vault_public_endpoint_url
  token = hcp_vault_cluster_admin_token.vault_admin_token.token
  namespace = "admin"
}

resource "hcp_vault_cluster_admin_token" "vault_admin_token" {
  cluster_id = data.terraform_remote_state.vault.cluster_id
}

data "terraform_remote_state" "vault" {
  backend = "remote"

  config = {
    organization = "jamesoulman"
    workspaces = {
      name = "boundary-connect-lab-vault"
    }
  }
}

