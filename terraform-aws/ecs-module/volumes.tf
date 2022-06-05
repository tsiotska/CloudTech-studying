resource "aws_efs_file_system" "efs_mongo" {}

resource "aws_efs_mount_target" "efs_mongo_target" {
  for_each = toset([
    aws_default_subnet.default_subnet_a.id,
    aws_default_subnet.default_subnet_b.id,
    aws_default_subnet.default_subnet_c.id
  ])

  file_system_id = aws_efs_file_system.efs_mongo.id
  subnet_id      = each.key
  depends_on     = [
    aws_default_subnet.default_subnet_a,
    aws_default_subnet.default_subnet_b,
    aws_default_subnet.default_subnet_c
  ]
  /* security_groups = [
     aws_security_group.efs.id,
   ]*/
}

/*resource "aws_efs_mount_target" "efs_mongo_target_c" {
  file_system_id = aws_efs_file_system.efs_mongo.id
  subnet_id      = aws_default_subnet.default_subnet_c.id

  *//* security_groups = [
     aws_security_group.efs.id,
   ]*//*
}*/
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
