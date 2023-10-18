terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
    }
  }
#  backend "remote" {
#      hostname = "app.terraform.io"
#      organization = "shizukux0x"
#
#      workspaces {
#        name = "terra-house-1"
#    }
#  }
#  cloud {
#      organizations = "shizukux0x"
#
#      workspaces {
#        name = "terra-house-1"
#      }
#  }
#
}

provider "terratowns" {
  endpoint = "http://localhost:4567/api"
  user_uuid="e328f4ab-b99f-421c-84c9-4ccea042c7d1" 
  token="9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
  
}

#module "terrahouse_aws" {
#  source = "./modules/terrahouse_aws"
#  user_uuid = var.user_uuid
#  bucket_name = var.bucket_name
#  error_html_filepath = var.error_html_filepath
#  index_html_filepath = var.index_html_filepath
#  content_version = var.content_version
#  assets_path = var.assets_path
#}

resource "terratowns_home" "home" {
  name = "My Top Songs of 2023!"
  description = <<DESCRIPTION
  This is a list my favorite 15 songs of 2023, with short descriptions and links to each.
  DESCRIPTION
  #domain_name = module.terrahouse_aws.cloudfront_url
  domain_name = "2n8g1kls.cloudfront.net"
  town = "video-valley"
  content_version = 1.0
}