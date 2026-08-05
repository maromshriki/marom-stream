resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "app_bucket" {
  bucket = "marom-stream-${random_id.suffix.hex}"
}

resource "aws_kms_key" "s3_key" {
  description             = "KMS key for S3 bucket encryption"
  deletion_window_in_days = 30
  enable_key_rotation     = true

  tags = {
    Name = "s3-encryption-key"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "app_bucket" {

  bucket = aws_s3_bucket.app_bucket.id

  rule {
    apply_server_side_encryption_by_default {

      sse_algorithm = "aws:kms"

      kms_master_key_id = aws_kms_key.s3_key.arn
    }
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.app_bucket.id

  versioning_configuration {
    status = "Enabled"
  }

}
resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.app_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.app_bucket.id

  rule {
    id     = "move-to-cold"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }
  }
}

resource "aws_s3_object" "seed_movies" {

  bucket = aws_s3_bucket.app_bucket.id

  key = "seed/movies.json"

  source = "${path.root}/../magic-stream-seed-data/movies.json"

  etag = filemd5("${path.root}/../magic-stream-seed-data/movies.json")
}


resource "aws_s3_object" "seed_users" {

  bucket = aws_s3_bucket.app_bucket.id

  key = "seed/users.json"

  source = "${path.root}/../magic-stream-seed-data/users.json"

  etag = filemd5("${path.root}/../magic-stream-seed-data/users.json")
}


resource "aws_s3_object" "seed_genres" {

  bucket = aws_s3_bucket.app_bucket.id

  key = "seed/genres.json"

  source = "${path.root}/../magic-stream-seed-data/genres.json"

  etag = filemd5("${path.root}/../magic-stream-seed-data/genres.json")
}