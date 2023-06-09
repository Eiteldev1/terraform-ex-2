resource "aws_instance" "web-server" {
  ami           = var.web_server_ami
  instance_type = var.web_server_instance_type
  associate_public_ip_address = true
  availability_zone = var.azs[0]
  subnet_id = aws_subnet.public_subnet.id

  tags = {
    Name = "${var.vpc_name}-${var.web_server_instance_name}"
  }
}

resource "aws_key_pair" "my_key" {
  key_name   = "my_assg_key"
  public_key = tls_private_key.private_key.public_key_openssh
}

resource "aws_instance" "app-server" {
  ami           = var.app_server_ami
  instance_type = var.app_server_instance_type
  availability_zone = var.azs[1]
  subnet_id = aws_subnet.private_subnet.id
  key_name = aws_key_pair.my_key.key_name
  tags = {
    Name = "${var.vpc_name}-${var.app_server_instance_name}"
  }
}