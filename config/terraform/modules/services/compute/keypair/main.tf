resource "aws_key_pair" "kp" {
  key_name = var.keyname
  public_key = var.public_key
  tags = {
    Name: var.keyname
  }
}