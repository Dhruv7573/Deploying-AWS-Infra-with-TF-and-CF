# -------------------------
# RDS SUBNET GROUP
# -------------------------
resource "aws_db_subnet_group" "db_subnets" {
  name       = "dhruv-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "dhruv-rds-subnet-group"
  }
}

# -------------------------
# RDS SECURITY GROUP
# -------------------------
resource "aws_security_group" "rds_sg" {
  vpc_id = var.vpc_id

  # Allow EC2 to connect to RDS
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.ec2_sg_id]   # EC2 SG allowed
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dhruv-rds-sg"
  }
}

# -------------------------
# RDS INSTANCE
# -------------------------
resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"   # Free-tier

  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.db_subnets.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  publicly_accessible  = false   # IMPORTANT
  skip_final_snapshot  = true

  tags = {
    Name = "dhruv-mysql-rds"
  }
}
