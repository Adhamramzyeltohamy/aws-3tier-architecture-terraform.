resource "aws_instance" "bastion" {
  ami           = "ami-02dfbd4ff395f2a1b" 
  instance_type = "t3.micro"

  subnet_id = aws_subnet.public_az1.id

  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  key_name = aws_key_pair.main_key.key_name 

  tags = {
    Name = "bastion-host"
  }
}

