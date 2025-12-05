resource "aws_s3_bucket" "student_buckets" {
  count  = 4
  bucket = "${var.bucket_prefix}-bucket-${count.index + 1}"
}

resource "aws_s3_bucket_versioning" "versioning" {
  count = 4
  bucket = aws_s3_bucket.student_buckets[count.index].id

  versioning_configuration {
    status = "Enabled"
  }
}
