resource "aws_instance" "ec2" {
    subnet_id = var.subnet_id
    ami = var.ami
    instance_type = var.instance_type
    associate_public_ip_address = var.aasociate_public_ip
    security_groups = var.sg
    tags = {
      Name: var.instance_name
    }

    provisioner "local-exec" {
      command = "echo ${self.public_ip} > ../../ansible/hosts"
    }

}