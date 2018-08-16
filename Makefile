################################################
# VARIABLES
################################################

region = eu-west-1
environment = prod
application = vita-mojo

################################################
# TARGETS
################################################

validate:
	terraform validate -var "region=$(region)" -var "environment=$(environment)" -var-file "terraform/$(environment).tfvars" terraform/

update-modules:
	rm -rf .terraform
	terraform get terraform/

init:
	terraform init -input=false -backend-config="key=terraform-state" -backend-config="region=$(region)" -backend-config="bucket=$(application)" terraform/

plan:
	terraform plan -input=false -var "region=${region}" -var "environment=${environment}" -var-file "terraform/${environment}.tfvars" -out "tf.plan" -refresh=true terraform/

apply:
	terraform apply -auto-approve -refresh=true -input=false "tf.plan"

################################################
# TERRAFORM ACTIONS
################################################

plan: update-modules init validate plan
apply: update-modules init validate plan apply
