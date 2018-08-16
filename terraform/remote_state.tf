# Read / write state for this module from S3
terraform {
  backend "s3" {
    encrypt        = "true"
    region         = "eu-west-1"
  }
}
