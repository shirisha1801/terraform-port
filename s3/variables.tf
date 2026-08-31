variable "buckets" {
  type = map(object({
    region = string
  }))
}

variable "aws_region" {
  type = string
}
