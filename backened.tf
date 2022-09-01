terraform {
  backend "s3" {
    bucket = "code-deploy-backened-bucket"
    key    = "main
    region = "us-east-1"
  }
}