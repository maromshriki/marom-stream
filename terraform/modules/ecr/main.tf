resource "aws_ecr_repository" "backend" {
  name = "maromstream-backend"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "maromstream-backend"
  }
}

resource "aws_ecr_repository" "frontend" {
  name = "maromstream-frontend"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "maromstream-frontend"
  }
}

output "backend_repository_url" {
  value = aws_ecr_repository.backend.repository_url
}

output "frontend_repository_url" {
  value = aws_ecr_repository.frontend.repository_url
}