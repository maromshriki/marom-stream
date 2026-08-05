
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  vpc_id      = var.vpc_id
  description = "Allow inbound HTTP and HTTPS from the internet to the ALB"

  ingress {
    description = "Allow HTTP traffic from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS traffic from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description     = "Allow ALB to connect to frontend on port 80"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend_sg.id]
  }

  egress {
    description     = "Allow ALB to connect to backend on port 8080"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.backend_sg.id]
  }
}

resource "aws_security_group" "frontend_sg" {
  name        = "frontend-sg"
  description = "Allow traffic from the ALB to the frontend instances"
  vpc_id      = var.vpc_id

  egress {
    description     = "Allow frontend to connect to backend on port 8080"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.backend_sg.id]
  }
  egress {
    description = "Allow HTTPS outbound"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow DNS resolution"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "backend_sg" {
  name        = "backend-sg"
  description = "Allow traffic from the frontend tier to the backend instances"
  vpc_id      = var.vpc_id

  egress {
    description     = "Allow backend to MongoDB"
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [aws_security_group.db_sg.id]
  }

  egress {
    description = "Allow DNS resolution"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow HTTPS outbound for AWS services"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "frontend_from_alb" {
  type                     = "ingress"
  description              = "Allow traffic from ALB port 80"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.frontend_sg.id
  source_security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "backend_from_frontend" {
  type                     = "ingress"
  description              = "Allow traffic from frontend on port 8080"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.backend_sg.id
  source_security_group_id = aws_security_group.frontend_sg.id
}

resource "aws_security_group_rule" "backend_from_alb" {
  type                     = "ingress"
  description              = "Allow traffic from ALB on port 8080"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.backend_sg.id
  source_security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group" "db_sg" {
  vpc_id = var.vpc_id

  name = "db-sg"
}
resource "aws_vpc_security_group_ingress_rule" "db_from_backend" {
  security_group_id            = aws_security_group.db_sg.id
  referenced_security_group_id = aws_security_group.backend_sg.id

  from_port   = 27017
  to_port     = 27017
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "backend_to_db" {
  security_group_id            = aws_security_group.backend_sg.id
  referenced_security_group_id = aws_security_group.db_sg.id

  from_port   = 27017
  to_port     = 27017
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "db_from_lambda" {

  security_group_id = aws_security_group.db_sg.id

  referenced_security_group_id = var.lambda_sg_id

  from_port = 27017
  to_port   = 27017

  ip_protocol = "tcp"

  description = "Allow Lambda to DocumentDB"
}