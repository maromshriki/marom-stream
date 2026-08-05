data "aws_caller_identity" "current" {}

resource "aws_iam_role" "lambda_role" {
  name = "magicstream-seed-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "lambda.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {

  role = aws_iam_role.lambda_role.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "lambda_s3_read" {

  name = "lambda-read-seed-files"

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]

        Resource = [
          var.s3_bucket_arn,
          "${var.s3_bucket_arn}/*"
        ]
      }

    ]
  })
}

resource "aws_iam_policy" "lambda_secrets_read" {

  name = "lambda-read-docdb-secrets"

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {
        Effect = "Allow"

        Action = [
          "secretsmanager:GetSecretValue"
        ]

        Resource = [
          "arn:aws:secretsmanager:${var.region}:${data.aws_caller_identity.current.account_id}:secret:mongosecret-*"
        ]
      }

    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_s3" {

  role = aws_iam_role.lambda_role.name

  policy_arn = aws_iam_policy.lambda_s3_read.arn
}

resource "aws_iam_policy" "lambda_kms" {

  name = "lambda-kms-decrypt"

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {
        Effect = "Allow"

        Action = [
          "kms:Decrypt"
        ]

        Resource = [
          var.kms_key_arn
        ]
      }

    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_kms" {

  role = aws_iam_role.lambda_role.name

  policy_arn = aws_iam_policy.lambda_kms.arn
}

resource "aws_security_group" "lambda_sg" {
  name        = "lambda-seed-sg"
  description = "Allow Lambda to access DocumentDB"
  vpc_id      = var.vpc_id

  egress {
    description     = "Lambda to DocumentDB"
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [var.db_sg_id]
  }

  egress {
    description = "HTTPS for AWS services"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "DNS resolution"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_role_policy_attachment" "lambda_secrets" {

  role = aws_iam_role.lambda_role.name

  policy_arn = aws_iam_policy.lambda_secrets_read.arn

}

resource "aws_lambda_function" "seed" {

  function_name = "magicstream-seed"

  filename = "${path.root}/../lambda/lambda.zip"

  source_code_hash = filebase64sha256(
    "${path.root}/../lambda/lambda.zip"
  )

  role = aws_iam_role.lambda_role.arn

  handler = "seed.lambda_handler"

  runtime = "python3.12"

  timeout = 60

  memory_size = 512


  vpc_config {

    subnet_ids = var.private_subnet_ids

    security_group_ids = [
      aws_security_group.lambda_sg.id
    ]
  }


  environment {

    variables = {

      DOCDB_ENDPOINT = var.db_endpoint

      BUCKET = var.s3_bucket_name

      MONGO_SECRET_NAME = "mongosecret"
    }
  }
}

resource "aws_iam_role_policy_attachment" "lambda_vpc_access" {

  role = aws_iam_role.lambda_role.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"

}