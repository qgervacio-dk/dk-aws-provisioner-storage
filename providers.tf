terraform {
  required_version = "~> 1.7"
  backend "s3" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.43.0"
    }
  }

}

provider "aws" {
  region = var.common.region
}