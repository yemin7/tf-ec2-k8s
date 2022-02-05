terraform {
  cloud {
    organization = "" #define organization name
    workspaces {
      name = "ec2-k8s"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.70.0"
    }
  }
}

provider "aws" {
  region = var.region
}
