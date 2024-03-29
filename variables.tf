variable "common" {
  type = object({
    env    = string
    region = string
  })
}

variable "storage" {
  type = object({
    s3 = object({
      default = object({
        name_prefix = string
        acl         = string
        versioning  = string
      })
      resources = list(object({
        name                     = string
        control_object_ownership = bool
        object_ownership         = string
        acl                      = optional(string)
        versioning               = optional(string)
      }))
    })
  })
}

locals {
  s3_default = var.storage.s3.default
  s3_buckets = { for idx, bucket in var.storage.s3.resources : idx => bucket }
}
