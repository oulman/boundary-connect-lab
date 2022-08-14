terraform {
  backend "remote" {
    organization = "jamesoulman"

    workspaces {
      name = "boundary-connect-lab-vault"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "0.40.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

provider "hcp" {
  # Configuration options
}

data "terraform_remote_state" "global" {
  backend = "remote"

  config = {
    organization = "jamesoulman"
    workspaces = {
      name = "boundary-connect-lab-global"
    }
  }
}

