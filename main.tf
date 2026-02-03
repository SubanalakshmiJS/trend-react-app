provider "aws" {
  region = "ap-south-1"
}

data "aws_vpc" "default" {
  default = true
}
