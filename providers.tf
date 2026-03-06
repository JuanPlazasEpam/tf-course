terraform {
  backend "s3" {
    bucket  = "cmtr-gqdgh5re-backend-new-bucket-1772817210"
    region  = "us-east-1"
    encrypt = true
  }
}