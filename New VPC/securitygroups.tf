resource "aws_security_group" "openarena_sg" {
  name   = "${terraform.workspace}-sg"
  vpc_id = aws_vpc.workspace_vpc.id
 
  ingress {
   protocol         = "udp"
   from_port        = 27960
   to_port          = 27960
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
  }
 
  egress {
   protocol         = "-1"
   from_port        = 0
   to_port          = 0
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
  }
}