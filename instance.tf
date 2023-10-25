#Instance 
resource "aws_instance" "mylab_instance" {
  ami                    = var.aws_ami
  instance_type          = "t2.micro"
  key_name               = "myat_soe-_kp"
  subnet_id              = aws_subnet.mylab_subnet_public.id
  vpc_security_group_ids = [aws_security_group.mylab_sg.id]
  user_data              = file("apache-install.sh")
  associate_public_ip_address = true
  count = var.aws_count
  #count use how many resource create
  #count = var.aws_count 
  tags = {
    "Name" = "web-${count.index}"
  }

}

