resource "aws_docdb_subnet_group" "docdb_subnet_group" {
  name       = "docdb-subnet-group"
  subnet_ids = var.private_subnet_ids
}

resource "aws_docdb_cluster" "docdb" {
  cluster_identifier      = "docdb-cluster"
  engine                  = "docdb"
  master_username         = var.docdb_username
  master_password         = var.docdb_password
  backup_retention_period = 1
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_docdb_subnet_group.docdb_subnet_group.name
  vpc_security_group_ids  = [var.db_sg_id]
  storage_encrypted       = true
}

resource "aws_docdb_cluster_instance" "docdb_instance" {
  identifier         = "docdb-instance"
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = "db.t3.medium"
}