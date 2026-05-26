provider "aws" {
  region = "eu-west-2"
}

module "s3_versioning" {
  source = "../../"

  namespace   = "psp"
  environment = "dev"
  name        = "assets"

  bucket_id         = "psp-dev-assets"
  versioning_status = "Enabled"
}

output "id" {
  value = module.s3_versioning.id
}
