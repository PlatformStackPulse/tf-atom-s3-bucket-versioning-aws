# -----------------------------------------------------------------------------
# Unit tests — tf-atom-s3-bucket-versioning-aws
#
# Uses a mocked AWS provider so no real API calls are made. Assertions target
# ONLY plan-known values (tf-label id, input pass-throughs, resource count),
# never computed arn/id which are unknown under a mock provider.
# -----------------------------------------------------------------------------
mock_provider "aws" {}

variables {
  # tf-label identity inputs
  namespace = "eg"
  stage     = "test"
  name      = "thing"

  # module-specific required input
  bucket_id = "eg-test-thing-bucket"
}

# Enabled path — the resource is planned and pass-through outputs resolve.
run "creates_when_enabled" {
  command = plan

  assert {
    condition     = output.enabled == true
    error_message = "enabled output should be true when the module is enabled"
  }

  assert {
    condition     = length(aws_s3_bucket_versioning.this) == 1
    error_message = "exactly one aws_s3_bucket_versioning resource should be planned when enabled"
  }

  assert {
    condition     = output.versioning_status == "Enabled"
    error_message = "versioning_status should default to Enabled"
  }
}

# Suspended status is a plan-known pass-through.
run "supports_suspended_status" {
  command = plan

  variables {
    versioning_status = "Suspended"
  }

  assert {
    condition     = output.versioning_status == "Suspended"
    error_message = "versioning_status output should reflect the Suspended input"
  }
}

# Disabled path — count = 0, so no resource and the id output collapses to null.
run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = length(aws_s3_bucket_versioning.this) == 0
    error_message = "no aws_s3_bucket_versioning resource should be planned when disabled"
  }

  assert {
    condition     = output.id == null
    error_message = "id output should be null when the module is disabled"
  }

  assert {
    condition     = output.enabled == false
    error_message = "enabled output should be false when disabled"
  }
}
