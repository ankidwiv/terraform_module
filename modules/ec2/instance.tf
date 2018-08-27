resource "aws_instance" "my-instances" {
  count                  = "${var.instance_count}"
  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  key_name               = "${var.ssh_key}"
  user_data              = "${file("install.sh")}"
  subnet_id              = "${element(aws_subnet.Public_subnet.*.id, count.index%length(var.Public_subnet_cidrs))}"
  vpc_security_group_ids = ["${aws_security_group.Bastion_SG.id}"]
  iam_instance_profile = "${aws_iam_instance_profile.efs_test_profile.name}" 
  depends_on = ["aws_efs_mount_target.Drupal_efs_mount", "aws_efs_file_system.Drupal_efs"]
  tags {
    Name = "Terraform-${count.index +1}"
  }
}


resource "aws_iam_instance_profile" "efs_test_profile" {
  name = "efs_test_profile"
  role = "${aws_iam_role.efs_test_role.name}"
}
