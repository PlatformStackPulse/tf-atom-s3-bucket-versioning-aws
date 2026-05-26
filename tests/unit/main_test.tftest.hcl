mock_provider "aws" {}

run "enables_versioning_by_default" {
  variables {
    name        = "test"
    environment = "dev"
    namespace   = "unit"
    bucket_id   = "my-test-bucket"
  }

  assert {
    condition     = output.versioning_status == "Enabled"
    error_message = "Should default to Enabled versioning"
  }

  assert {
    condition     = output.id != null
    error_message = "id output should not be null when enabled"
  }
}

run "creates_nothing_when_disabled" {
  variables {
    name        = "test"
    environment = "dev"
    namespace   = "unit"
    enabled     = false
    bucket_id   = "my-test-bucket"
  }

  assert {
    condition     = length(aws_s3_bucket_versioning.this) == 0
    error_message = "No resource should be created when disabled"
  }
}

run "supports_suspended_status" {
  variables {
    name              = "test"
    environment       = "dev"
    namespace         = "unit"
    bucket_id         = "my-test-bucket"
    versioning_status = "Suspended"
  }

  assert {
    condition     = output.versioning_status == "Suspended"
    error_message = "Should support Suspended versioning"
  }
}
