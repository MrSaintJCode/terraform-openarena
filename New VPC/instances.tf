locals {
    jumphost_name = "${terraform.workspace}-jumphost"
}

# Jump host - Public Subnet
resource "aws_instance" "ec2jumphost" {
    ami                     = var.jumphost_ami
    instance_type           = var.jumphost_instancetype
    key_name                = var.jumphost_sshkey
    subnet_id               = aws_subnet.workspace_public_subnet_1a.id
    vpc_security_group_ids  =  ["${aws_security_group.jumphost_sg.id}"]

    tags = {
      "Name"         = local.jumphost_name
      "Env"          = "${terraform.workspace}"
      "Project"      = "${terraform.workspace}"
      "DeployedWith" = "terraform"
    }
}

# Elastic IP for Jumphost
resource "aws_eip" "jumphost" {
    instance    = aws_instance.ec2jumphost.id
    vpc         = true
}