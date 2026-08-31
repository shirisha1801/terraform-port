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
  for_each = var.buckets

   bucket = each.key
}

output "bucket_names" {
  value = {
     for name, bucket in aws_s3_bucket.bucket :
     name => bucket.id
  }
}
