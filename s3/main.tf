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

# ---------------------------------------------------
# AWS providers for supported regions
# ---------------------------------------------------

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

provider "aws" {
  alias  = "us_east_2"
  region = "us-east-2"
}

provider "aws" {
  alias  = "us_west_1"
  region = "us-west-1"
}

provider "aws" {
  alias  = "us_west_2"
  region = "us-west-2"
}

# ---------------------------------------------------
# Separate bucket maps based on region
# ---------------------------------------------------

locals {
  buckets_us_east_1 = {
    for name, config in var.buckets :
    name => config
    if config.region == "us-east-1"
  }

  buckets_us_east_2 = {
    for name, config in var.buckets :
    name => config
    if config.region == "us-east-2"
  }

  buckets_us_west_1 = {
    for name, config in var.buckets :
    name => config
    if config.region == "us-west-1"
  }

  buckets_us_west_2 = {
    for name, config in var.buckets :
    name => config
    if config.region == "us-west-2"
  }
}

# ---------------------------------------------------
# S3 buckets
# ---------------------------------------------------

resource "aws_s3_bucket" "us_east_1" {
  provider = aws.us_east_1
  for_each = local.buckets_us_east_1

  bucket = each.key
}

resource "aws_s3_bucket" "us_east_2" {
  provider = aws.us_east_2
  for_each = local.buckets_us_east_2

  bucket = each.key
}

resource "aws_s3_bucket" "us_west_1" {
  provider = aws.us_west_1
  for_each = local.buckets_us_west_1

  bucket = each.key
}

resource "aws_s3_bucket" "us_west_2" {
  provider = aws.us_west_2
  for_each = local.buckets_us_west_2

  bucket = each.key
}

output "bucket_names" {
  value = concat(
    keys(aws_s3_bucket.us_east_1),
    keys(aws_s3_bucket.us_east_2),
    keys(aws_s3_bucket.us_west_1),
    keys(aws_s3_bucket.us_west_2)
  )
}
