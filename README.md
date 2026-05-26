# tf-atom-s3-bucket-versioning-aws

[![CI](https://github.com/PlatformStackPulse/tf-atom-s3-bucket-versioning-aws/actions/workflows/ci.yml/badge.svg)](https://github.com/PlatformStackPulse/tf-atom-s3-bucket-versioning-aws/actions/workflows/ci.yml)
[![Release](https://github.com/PlatformStackPulse/tf-atom-s3-bucket-versioning-aws/actions/workflows/auto-release.yml/badge.svg)](https://github.com/PlatformStackPulse/tf-atom-s3-bucket-versioning-aws/actions/workflows/auto-release.yml)

---

## Purpose

Configures object versioning for an S3 bucket. Versioning preserves all versions of objects, enabling recovery from unintended deletions or overwrites. Defaults to Enabled.

## Architecture

```
┌─────────────────────────────────────────────────┐
│           Molecule Layer                        │
│  ┌──────────────┐    ┌────────────────────┐    │
│  │ s3-bucket    │───▶│ THIS MODULE        │    │
│  │ (bucket_id)  │    │ versioning         │    │
│  └──────────────┘    │ (Enabled/Suspended)│    │
│                      └────────────────────┘    │
└─────────────────────────────────────────────────┘
```

## Scope

| In Scope | Out of Scope |
|----------|--------------|
| `aws_s3_bucket_versioning` resource | Bucket creation (→ `tf-atom-s3-bucket-aws`) |
| Enabled/Suspended/Disabled status | Lifecycle rules for versions (→ `tf-atom-s3-bucket-lifecycle-configuration-aws`) |
| MFA delete configuration | Object lock (separate atom) |
| Conditional creation (`enabled`) | Replication (separate atom) |

## Features

- **Single-resource atom** — one `aws_s3_bucket_versioning`
- **Enabled by default** — versioning is on unless explicitly changed
- **MFA delete support** — optional MFA requirement for permanent deletes
- **Validation** — enforces valid status values
- **Tested** — unit tests for enabled, disabled, and suspended

## Usage

```hcl
module "bucket_versioning" {
  source = "github.com/PlatformStackPulse/tf-atom-s3-bucket-versioning-aws?ref=v1.0.0"

  context   = module.this.context
  bucket_id = module.bucket.bucket_id

  versioning_status = "Enabled"  # default
}
```

## Module Documentation

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
