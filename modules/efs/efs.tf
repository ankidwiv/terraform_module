resource "aws_efs_file_system" "Drupal_efs" {
  creation_token = "Drupal_efs"

  tags {
    Name = "Drupal_efs"
  }
}

resource "aws_efs_mount_target" "Drupal_efs_mount" {
  count           = "${length(var.Public_subnet_cidrs)}"
  file_system_id  = "${aws_efs_file_system.Drupal_efs.id}"
  subnet_id       = "${element(aws_subnet.Public_subnet.*.id, count.index)}"
  security_groups = ["${aws_security_group.efs_SG.id}"]
}
