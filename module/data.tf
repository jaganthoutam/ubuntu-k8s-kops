terraform = {
  required_version = ">= 0.10.6"
}

data "aws_availability_zones" "available" {}

data "aws_region" "current" {}

data "aws_ami" "k8s_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["${local.ami_name}"]
  }

  filter {
    name   = "owner-id"
    values = ["099720109477"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}
