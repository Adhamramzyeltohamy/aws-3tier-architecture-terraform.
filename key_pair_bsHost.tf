resource "aws_key_pair" "main_key" {
  key_name   = "my-key"
  public_key = file("~/.ssh/id_rsa.pub")  
}

