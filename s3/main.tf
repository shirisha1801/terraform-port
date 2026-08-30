terraform {
  cloud {
    organization = "shirisha-lab"

    workspaces {
      name = "port-lab"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
}

output "bucket_name" {
  value = aws_s3_bucket.bucket.id
}
