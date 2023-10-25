output "public_ip" {
    description = "Public IP"
    value = aws_instance.mylab_instance.*.public_ip
  
}