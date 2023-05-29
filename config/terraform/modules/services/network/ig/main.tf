resource "aws_internet_gateway" "ig" {
   vpc_id = var.vpcid
   tags = {
     Name: var.igname
   }
}

resource "aws_route_table" "rt" {
  vpc_id = var.vpcid
  route {
    cidr_block = var.rtcidr
    gateway_id = aws_internet_gateway.ig.id
  }
  tags = {
    Name: var.rtname
  }
}

resource "aws_route_table_association" "rtassoc" {
  route_table_id = aws_route_table.rt.id
  subnet_id = var.subnetid
}