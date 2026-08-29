terraform {
  backend "s3" {
    bucket       = "devops-assignment-tfstate-parihruda"
    key          = "devops-assignment/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}