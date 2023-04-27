output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.mms_server.id

}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.mms_server.public_ip

}

output "security_group_id" {
  value = aws_security_group.mms_rds_sg.id
}

output "db_instance_endpoint" {
  value = aws_db_instance.mmsdb.endpoint

}