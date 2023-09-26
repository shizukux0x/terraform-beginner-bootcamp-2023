terraform {
  #cloud {
  #  organization = "shizukux0x"
  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}
provider "aws" {
  # Configuration options
}

provider "random" {
  # Configuration options
}
