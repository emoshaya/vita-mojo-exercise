# Create EC2 Container Registry Repository

resource "aws_ecr_repository" "ecr_repo" {
  name = "${var.application_name}"
}
