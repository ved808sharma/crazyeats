resource "aws_security_group" "sg" {
  vpc_id = var.vpcid
  ingress {
    cidr_blocks = var.ingresscidr
    from_port = var.fromport
    to_port = var.toport
    protocol = var.protocol
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = "0"
    to_port = "0"
    protocol = "-1"
  }
  tags = {
    Name: var.sgname
  }
}