terraform {
  required_version = ">= 0.11.0"
}

provider "aws" {
  profile = "terraform-hands-on"
  region = "ap-northeast-1"
  version = "~> 1.7.1"
}