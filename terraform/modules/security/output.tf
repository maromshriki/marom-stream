output "frontend_sg_id" {
  value = aws_security_group.frontend_sg.id
}

output "backend_sg_id" {
  value = aws_security_group.backend_sg.id
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "db_sg_id" {
  value = aws_security_group.db_sg.id
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.ec2_profile.name
}