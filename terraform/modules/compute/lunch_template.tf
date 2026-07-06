resource "aws_launch_template" "backend" {
  name_prefix   = "backend-"
  image_id      = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"

  vpc_security_group_ids = [var.backend_sg_id]

  iam_instance_profile {
    name = var.instance_profile_name
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    set -euo pipefail

    echo "DB_HOST=${var.db_endpoint}" >> /etc/environment

    yum update -y
    yum install -y docker aws-cli

    systemctl enable docker
    systemctl start docker

    REGION="us-east-1"
    REGISTRY="$(echo "${var.backend_repository_url}" | cut -d'/' -f1)"

    aws ecr get-login-password --region "$REGION" \
      | docker login --username AWS --password-stdin "$REGISTRY"

    docker pull "${var.backend_repository_url}:backend"
    docker run -d \
      --name backend \
      -p 8080:8080 \
      -e PORT=8080 \
      -e DB_HOST=${var.db_endpoint} \
      "${var.backend_repository_url}:backend"
  EOF
  )
}

resource "aws_launch_template" "frontend" {
  name_prefix   = "frontend-"
  image_id      = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"

  vpc_security_group_ids = [var.frontend_sg_id]

  iam_instance_profile {
    name = var.instance_profile_name
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    set -euo pipefail

    yum update -y
    yum install -y docker aws-cli

    systemctl enable docker
    systemctl start docker

    REGION="us-east-1"
    REGISTRY="$(echo "${var.frontend_repository_url}" | cut -d'/' -f1)"

    aws ecr get-login-password --region "$REGION" \
      | docker login --username AWS --password-stdin "$REGISTRY"

    docker pull "${var.frontend_repository_url}:frontend"
    docker run -d \
      --name frontend \
      -p 80:80 \
      "${var.frontend_repository_url}:frontend"
  EOF
  )
}