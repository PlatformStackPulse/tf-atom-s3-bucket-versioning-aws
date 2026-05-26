variable "bucket_id" {
  description = "ID (name) of the S3 bucket to configure versioning for"
  type        = string
}

variable "versioning_status" {
  description = "Versioning status: Enabled, Suspended, or Disabled"
  type        = string
  default     = "Enabled"

  validation {
    condition     = contains(["Enabled", "Suspended", "Disabled"], var.versioning_status)
    error_message = "versioning_status must be one of: Enabled, Suspended, Disabled"
  }
}

variable "mfa_delete" {
  description = "MFA delete status: Enabled or Disabled"
  type        = string
  default     = "Disabled"

  validation {
    condition     = contains(["Enabled", "Disabled"], var.mfa_delete)
    error_message = "mfa_delete must be one of: Enabled, Disabled"
  }
}
