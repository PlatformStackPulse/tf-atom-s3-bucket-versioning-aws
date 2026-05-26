output "enabled" {
  description = "Whether the module is enabled."
  value       = local.enabled
}

output "id" {
  description = "ID of the versioning configuration"
  value       = try(aws_s3_bucket_versioning.this[0].id, null)
}

output "versioning_status" {
  description = "The versioning status"
  value       = var.versioning_status
}
