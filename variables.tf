variable "common" {
  type = object({
    env     = string
    account = string
  })
}

variable "storage" {
  type = object({
    s3 = object({
      default = object({
        name_prefix = string
        versioning = object({
          enabled = bool
        })
      })
      resources = list(object({
        name                     = string
        acl                      = string
        control_object_ownership = bool
        object_ownership         = string
        versioning = object({
          enabled = bool
        })
      }))
    })
  })
}
