resource "aws_s3_bucket" "storage" {
  bucket = "cmtr-gqdgh5re-bucket-1772735711"

  tags = {
    Project = "cmtr-gqdgh5re"
  }
}

