output "id" {
  value       = "${aws_efs_file_system.Drupal_efs.id}"
  description = "EFS id"
}

output "dns_name" {
  value       = "${aws_efs_file_system.Drupal_efs.id}.efs.${var.aws_region}.amazonaws.com"
  description = "DNS name"
}

output "mount_target_ids" {
  value       = ["${aws_efs_mount_target.Drupal_efs_mount.*.id}"]
  description = "List of IDs of the EFS mount targets (one per Availability Zone)"
}

output "mount_target_ips" {
  value       = ["${aws_efs_mount_target.Drupal_efs_mount.*.ip_address}"]
  description = "List of IPs of the EFS mount targets (one per Availability Zone)"
}
