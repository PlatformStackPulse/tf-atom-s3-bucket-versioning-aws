# -----------------------------------------------------
# Atom: S3 Bucket Versioning
# Configures object versioning for an S3 bucket.
# -----------------------------------------------------
resource "aws_s3_bucket_versioning" "this" {
  count = module.this.enabled ? 1 : 0

  bucket = var.bucket_id

  versioning_configuration {
    status     = var.versioning_status
    mfa_delete = var.mfa_delete
  }
}
