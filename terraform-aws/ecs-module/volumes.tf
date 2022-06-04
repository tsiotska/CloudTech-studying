resource "aws_efs_file_system" "efs_mongo" {}

resource "aws_efs_mount_target" "efs_mongo_target" {
  count = 3

  file_system_id = aws_efs_file_system.efs_mongo.id
  subnet_id      = aws_default_subnet.default_subnet_a

 /* security_groups = [
    aws_security_group.efs.id,
  ]*/
}

resource "aws_efs_mount_target" "efs_mongo_target" {
  count = 3

  file_system_id = aws_efs_file_system.efs_mongo.id
  subnet_id      = aws_default_subnet.default_subnet_b

  /* security_groups = [
     aws_security_group.efs.id,
   ]*/
}

resource "aws_efs_mount_target" "efs_mongo_target" {
  count = 3

  file_system_id = aws_efs_file_system.efs_mongo.id
  subnet_id      = aws_default_subnet.default_subnet_c

  /* security_groups = [
     aws_security_group.efs.id,
   ]*/
}
/*
resource "aws_security_group" "efs" {
  name        = "efs-mnt"
  description = "Allows NFS traffic from instances within the VPC."
  vpc_id      = aws_default_vpc.default_vpc.id

  ingress {
    from_port = 2049
    to_port   = 2049
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 2049
    to_port   = 2049
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}*/
