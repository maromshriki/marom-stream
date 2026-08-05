output "db_endpoint" {
  value = aws_docdb_cluster.docdb.endpoint
}

output "bucket_name" {
  value = aws_s3_bucket.app_bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.app_bucket.arn
}

output "kms_key_arn" {
  value = aws_kms_key.s3_key.arn
}