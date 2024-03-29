module "s3_buckets" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "2.13.0"

  for_each = local.s3_buckets

  acl                      = null # suppress warning
  bucket                   = "${local.s3_default.name_prefix}${each.value.name}"
  control_object_ownership = each.value.control_object_ownership
  object_ownership         = each.value.object_ownership
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  for_each = module.s3_buckets

  bucket = each.value.s3_bucket_id
  acl    = coalesce(local.s3_buckets[each.key].acl, local.s3_default.acl)
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  for_each = module.s3_buckets

  bucket = each.value.s3_bucket_id
  versioning_configuration {
    status = coalesce(local.s3_buckets[each.key].versioning, local.s3_default.versioning)
  }
}
