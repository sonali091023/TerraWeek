#If your assignment is to demonstrate count, output all instances as well as ip addresses of all instances. You can use the following code to output the instance IDs and public IPs of all instances created using count.:
output "instance_ids" {
  description = "IDs of all EC2 instances"
  value       = aws_instance.web[*].id
}

output "public_ips" {
  description = "Public IPs of all EC2 instances"
  value       = aws_instance.web[*].public_ip
}

#If you only want the first EC2 instance:
output "instance_id" {
  value = aws_instance.web[0].id
}

output "public_ip" {
  value = aws_instance.web[0].public_ip
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_id" {
  value = aws_subnet.public.id
}

output "ami_id" {
  value = data.aws_ami.amazon_linux.id
}