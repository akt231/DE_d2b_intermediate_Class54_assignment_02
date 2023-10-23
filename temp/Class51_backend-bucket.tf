resource "aws_s3_bucket" "d2b_bucket" {
  bucket = "terraform-data2bots-remote-backend"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.d2b_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

output "backend_bucket"{
	value = aws_s3_bucket.d2b_bucket.bucket
}