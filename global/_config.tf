terraform {
  backend "remote" {
    organization = "jamesoulman"

    workspaces {
      name = "boundary-connect-lab-global"
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
