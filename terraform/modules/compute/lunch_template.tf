resource "aws_launch_template" "backend" {
  name_prefix   = "backend-"
  image_id      = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"

  vpc_security_group_ids = [var.backend_sg_id]

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

  iam_instance_profile {
    name = var.instance_profile_name
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    set -euo pipefail

    yum update -y
    yum install -y docker aws-cli jq wget

    systemctl enable docker
    systemctl start docker
    usermod -aG docker ec2-user

    REGION="us-east-1"
    REGISTRY="$(echo "${var.backend_repository_url}" | cut -d'/' -f1)"

    SECRET=$(aws secretsmanager get-secret-value \
    --secret-id mongosecret \
    --region us-east-1
    --query SecretString \
    --output text)

    MONGODB_URI=$(echo "$SECRET" | jq -r .MONGODB_URI)
    DATABASE_NAME=$(echo "$SECRET" | jq -r .DATABASE_NAME)
    ALLOWED_ORIGINS=$(echo "$SECRET" | jq -r .ALLOWED_ORIGINS)

    aws ecr get-login-password --region "$REGION" \
      | docker login --username AWS --password-stdin "$REGISTRY"

    mkdir -p /app/certs

    wget https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem \
    -O /app/certs/global-bundle.pem  

    docker pull "${var.backend_repository_url}:backend"
    docker run -d \
       -v /app/certs:/app/certs \
      --name backend \
      --restart always \
      -p 8080:8080 \
      -e PORT=8080 \
      -e MONGODB_URI="$MONGODB_URI" \
      -e DATABASE_NAME="$DATABASE_NAME" \
      -e ALLOWED_ORIGINS="$ALLOWED_ORIGINS" \
      "${var.backend_repository_url}:backend"
  EOF
  )
}

resource "aws_launch_template" "frontend" {
  name_prefix   = "frontend-"
  image_id      = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"

  vpc_security_group_ids = [var.frontend_sg_id]

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

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
    usermod -aG docker ec2-user
    REGION="us-east-1"
    REGISTRY="$(echo "${var.frontend_repository_url}" | cut -d'/' -f1)"

    aws ecr get-login-password --region "$REGION" \
      | docker login --username AWS --password-stdin "$REGISTRY"
    docker pull "${var.frontend_repository_url}:frontend"
    docker run -d \
      --name frontend \
      --restart always \
      -p 80:80 \
      "${var.frontend_repository_url}:frontend"
  EOF
  )
}