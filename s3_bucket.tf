resource "aws_s3_bucket" "codedeploy-code-bucket" {
  bucket = "codedeploy-code-bucket"
  #region = "us-east-1"

}
resource "aws_s3_bucket_acl" "codedeploy-code-bucket" {
  bucket = aws_s3_bucket.codedeploy-code-bucket.id
  acl    = "private"

}
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.codedeploy-code-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
