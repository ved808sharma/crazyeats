resource "aws_subnet" "subnet" {
  vpc_id = var.vpc_id
  cidr_block = var.subnetcidr
  availability_zone = var.az
  tags = {
    Name: var.subnetname
  }
}