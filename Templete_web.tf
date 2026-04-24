resource "aws_launch_template" "web_lt" {
  name_prefix   = "web-template"
  image_id      = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"

  key_name = aws_key_pair.main_key.key_name 

  vpc_security_group_ids = [
    aws_security_group.web_sg.id
  ]

  user_data = base64encode(<<EOF
#!/bin/bash
yum update -y
amazon-linux-extras install nginx1 -y
systemctl start nginx
systemctl enable nginx
echo "Hello from Nginx Web Server" > /usr/share/nginx/html/index.html
EOF
  )
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "web-instance"
    }
  }
}