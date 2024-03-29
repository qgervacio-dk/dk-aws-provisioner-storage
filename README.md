<!-- BEGIN_TF_DOCS -->
# dk-aws-provisioner-storage

This provisioner repository shows how to use a blueprint/provisioner model.
It uses AWS [storage services](https://aws.amazon.com/products/storage/)
as an example to set up services on AWS storage related services.

## Object, file, and block storage

* [s3](https://aws.amazon.com/s3)
* [efs](https://aws.amazon.com/efs) (_TODO_)
* [fsx](https://aws.amazon.com/fsx) (_TODO_)
* [ebs](https://aws.amazon.com/ebs) (_TODO_)
* [filecache](https://aws.amazon.com/filecache) (_TODO_)

## Data migration

* [datasync](https://aws.amazon.com/datasync) (_TODO_)
* [snow](https://aws.amazon.com/snow) (_TODO_)

## Hybrid cloud storage and edge computing

* [storagegateway](https://aws.amazon.com/storagegateway) (_TODO_)

## Managed file transfer

* [aws-transfer-family](https://aws.amazon.com/aws-transfer-family) (_TODO_)

## Disaster recovery and backup

* [disaster-recovery](https://aws.amazon.com/disaster-recovery) (_TODO_)
* [backup](https://aws.amazon.com/backup) (_TODO_)

## Development Requirements

* [terraform](https://www.terraform.io/)
* [tf-summarize](https://github.com/dineshba/tf-summarize)
* [terraform-docs](https://github.com/terraform-docs/terraform-docs)

## Testing

Create an environment test file appropriately named `./test/.env-test`. This file is ignored in `.gitignore`, so you need not worry 
about including sensitive contents here.

```
# ./test/.env-test
TF_LOG=DEBUG
```

```
# get help
$ make help
```
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.7 |
| aws | 5.43.0 |

## Providers

| Name | Version |
|------|---------|
| aws | 5.43.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| s3\_buckets | terraform-aws-modules/s3-bucket/aws | 2.13.0 |

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket_acl.bucket_acl](https://registry.terraform.io/providers/hashicorp/aws/5.43.0/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_versioning.bucket_versioning](https://registry.terraform.io/providers/hashicorp/aws/5.43.0/docs/resources/s3_bucket_versioning) | resource |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| common | Common | <pre>object({<br>    env    = string<br>    region = string<br>  })</pre> | yes |
| storage | S3 storage | <pre>object({<br>    s3 = object({<br>      default = object({<br>        name_prefix              = string<br>        acl                      = string<br>        versioning               = string<br>        control_object_ownership = bool<br>        object_ownership         = string<br>      })<br>      resources = list(object({<br>        name                     = string<br>        acl                      = optional(string)<br>        versioning               = optional(string)<br>        object_ownership         = optional(string)<br>        control_object_ownership = optional(bool)<br>      }))<br>    })<br>  })</pre> | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->