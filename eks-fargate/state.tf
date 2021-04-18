terraform {
  backend "s3" {
    bucket = "lab-terraform-tfstate"
    key    = "eks/terraform.state"
    region = "us-west-2"
    profile = "awsgerson"
  }
}