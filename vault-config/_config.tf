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
  address = data.terraform_remote_state.vault.outputs.hcp_vault_public_endpoint_url
  token = var.hcp_vault_token
  namespace = "admin"
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

