.PHONY: help test build

help: ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \
	    \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ \
	    { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } \
	    /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.DEFAULT_GOAL  := help

# matches the "local" in local.terraform.tfvars.yaml just like in ci
workspace := local
bpdir := test

# s3 backend
tfstate_bucket := tf-state-bprint-prov-sample
tfstate_key := tfstate/storage/$(workspace)
tfstate_region := ap-southeast-1

# env vars for export
env_test := $(bpdir)/.env
include $(env_test)
export $(shell sed 's/=.*//' $(env_test))

##@ Docs

g: generate-readme
generate-readme: ## (g) Generate README
	@terraform-docs markdown . -c .terraform-docs.yml > README.md

##@ Deploy

i: init
init: ## (i) Init
	@terraform init \
		-backend-config="bucket=${tfstate_bucket}" \
		-backend-config="key=${tfstate_key}" \
		-backend-config="region=${tfstate_region}"
	@terraform workspace select $(workspace) || terraform workspace new $(workspace)
	@yq --prettyPrint $(bpdir)/$(workspace).terraform.tfvars.yaml -o=json > terraform.tfvars.json || exit 1
	@terraform fmt -recursive

p: plan
plan: ## (p) Plan
	@terraform plan -out tfplan && terraform show -json tfplan | tf-summarize

a: apply
apply: ## (a) Apply
	@terraform apply --auto-approve

d: destroy
destroy: ## (d) Destroy
	@terraform destroy --auto-approve
