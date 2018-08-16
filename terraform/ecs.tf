resource "aws_ecs_cluster" "main" {
  name = "${var.application_name}-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "${var.application_name}"
  network_mode             = "none"
  requires_compatibilities = ["FARGATE"]

  container_definitions = <<DEFINITION
[
  {
    "image": "https://s3-eu-west-1.amazonaws.com/vita-mojo/terraform-state/latest",
    "name": "${var.application_name}",
    "networkMode": "none"
  }
]
DEFINITION
}

resource "aws_ecs_service" "main" {
  name            = "${var.application_name}"
  cluster         = "${aws_ecs_cluster.main.id}"
  task_definition = "${aws_ecs_task_definition.app.arn}"
  desired_count   = "1"
  launch_type     = "FARGATE"

  depends_on = [
    "null_resource.packer",
  ]
}
