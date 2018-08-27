resource "aws_security_group" "LB_SG" {
  vpc_id = "${aws_vpc.My_Vpc.id}"
  name   = "lb_SG"

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "lb_SG"
  }
}

resource "aws_security_group" "Bastion_SG" {
  vpc_id = "${aws_vpc.My_Vpc.id}"
  name   = "Bastion_SG"

  ingress {
    from_port       = "80"
    to_port         = "80"
    protocol        = "TCP"
    security_groups = ["${aws_security_group.LB_SG.id}"]
  }

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "Bastion_SG"
  }
}

# security group for efs file system
resource "aws_security_group" "efs_SG" {
  name        = "efs_SG"
  description = "EFS"
  vpc_id      = "${aws_vpc.My_Vpc.id}"

  lifecycle {
    create_before_destroy = true
  }

  ingress {
    from_port       = "2049"                                  # NFS
    to_port         = "2049"
    protocol        = "tcp"
    security_groups = ["${aws_security_group.Bastion_SG.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "EFS_SG"
  }
}
