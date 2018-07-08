terraform {
  required_version = ">= 0.10.7"
}

data "aws_availability_zones" "available" {}

provider "aws" {
  region = "ap-southeast-2"
}
