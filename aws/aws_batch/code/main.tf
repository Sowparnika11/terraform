resource "aws_iam_role" "ecs_instance_role" {
  name = "${var.env_name}-ecs_instance_role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
            "Service": "ec2.amazonaws.com"
        }
    }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs_role_policy_attachement" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs_instance_role_profile" {
  name = "${var.env_name}-ecs_instance_role"
  role = aws_iam_role.ecs_instance_role.name
}

resource "aws_iam_role" "aws_batch_service_role" {
  name = "${var.env_name}-aws_batch_service_role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
        "Service": "batch.amazonaws.com"
        }
    }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "batch_role_policy_attachment" {
  role       = aws_iam_role.aws_batch_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBatchServiceRole"
}

resource "aws_security_group" "sample_security_group" {
  name = "${var.env_name}-security_group"
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_batch_compute_environment" "sample_env" {
  compute_environment_name = var.env_name

  compute_resources {
    instance_role = aws_iam_instance_profile.ecs_instance_role_profile.arn

    instance_type = [
      var.instance_type,
    ]

    max_vcpus = var.max_vcpu
    min_vcpus = var.min_vcpu
    desired_vcpus = var.desired_vcpu

    security_group_ids = [
      aws_security_group.sample_security_group.id,
    ]

    subnets = var.subnet_id

    type = var.resource_type
  }

  service_role = aws_iam_role.aws_batch_service_role.arn
  type         = var.env_type
  depends_on   = [aws_iam_role_policy_attachment.batch_role_policy_attachment]
}
resource "aws_batch_job_queue" "sample_job_queue" {
  name = var.queue_name
  state = var.queue_state
  priority = var.queue_priority
  compute_environments = [
    "${aws_batch_compute_environment.sample_env.arn}",
  ]
}
resource "aws_batch_job_definition" "sample_job_definition" {
  name = var.job_definition_name
  type = var.job_type

  container_properties = var.container_properties
  dynamic "retry_strategy" {
    for_each = var.retry_strategy != null ? [var.retry_strategy] : []
    content {
      attempts = lookup(retry_strategy.value, "attempts", null)
      dynamic "evaluate_on_exit" {
        for_each = try(retry_strategy.value.evaluate_on_exit, {})
        content {
          action           = evaluate_on_exit.value.action
          on_exit_code     = lookup(evaluate_on_exit.value, "on_exit_code", null)
          on_reason        = lookup(evaluate_on_exit.value, "on_reason", null)
          on_status_reason = lookup(evaluate_on_exit.value, "on_status_reason", null)
        }
      }
    }
  }

}
