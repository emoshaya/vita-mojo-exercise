data "external" "packer" {
  program = ["bash", "terraform/data_external_sha256sum.sh"]

  query = {
    sha256sum_dir = "packer/"
  }
}


# Provision Image via Packer
resource "null_resource" "packer" {

  triggers {
    packer_sha256sum             = "${data.external.packer.result.sha256sum}"
  }

  depends_on = [
    "aws_ecr_repository.ecr_repo",
  ]

  provisioner "local-exec" {
    command = <<EOT
packer build \
-var "aws_ecr_repository_url=${aws_ecr_repository.ecr_repo.repository_url}" \
-var "aws_ecr_repository_name=${aws_ecr_repository.ecr_repo.name}" \
-var "login_server=${aws_ecr_repository.ecr_repo.arn}" \
"packer/application.json"
EOT
  }
}
