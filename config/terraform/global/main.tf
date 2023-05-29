terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "crazyeats-vpc" {
  source = "../modules/services/network/vpc"
  vpc_cidr = "172.10.0.0/16"
  vpc_name = "crazyeats vpc"
}

module "crazyeats-subnet" {
  source = "../modules/services/network/subnet"
  vpc_id = module.crazyeats-vpc.vpcid
  subnetcidr = "172.10.1.0/24"
  az = "ap-south-1a"
  subnetname = "crazyeats-pubsn1"
}

module "crazyeats-ig" {
  source = "../modules/services/network/ig"
  subnetid = module.crazyeats-subnet.subnetid
  igname = "crazyeatsig"
  rtcidr = "0.0.0.0/0"
  rtname = "crazyeats-rt"
  vpcid = module.crazyeats-vpc.vpcid
}

module "crazyeats-kp" {
  source = "../modules/services/compute/keypair"
  keyname = "crazyeatskp"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDRCB6iq46zOzX3eu5MuhrkPsXksWC9uF7HEOMbzHYkZOpf71W7AuqLDzRcT2T6OsbHoSBja00BtiU60Dz34qSTGAgO6GOdBoiT9dcVYH4+ayqhvKQUTN59rLp+52Xo/gCzPnPqTVH24ThQOP46fPyG8teV7oio14VKynkyVp9APrKKiH5EgCwUAA3HRutrjT9g/mLkT3UJJQKNGrS0iz8JAOccOWtTwEStWEcbMhQDxFs5g0RCSJAdP9sp/OiNDwW8D1Wzl2ocGTdw46/GLYsn4fMDcBSxlJMdb5959Wr8gksYcb6xHgeWnHrvUKIfouCbcUj3/lLvJWuRvyv3I1VvSB4XoG5PmasVceh4N1Q5aYL0Tc3yux7VIrFSEHBXKDd+PVopLDWzUzM2JF4i0T9hoyiUWuAjFlEr3FOStNJuXcI6J6/1+lcj48pcPlCnHAiwhet+2Ozh6OXD6YUlWW0/qtYkVUtrpJGOZy2wVM/iOF1ErZG+CZkJSE/2K8tXsC0= ved@Vedprakashs-MacBook-Air.local"
}

module "crazyeats-sg" {
  source = "../modules/services/network/sg"
  sgname = "crazyeats-sg"
  vpcid = module.crazyeats-vpc.vpcid
  fromport = 22
  toport =  22
  ingresscidr = ["0.0.0.0/0"]
  protocol = "tcp"
}

module "crazyeats-ec2" {
  source = "../modules/services/compute/ec2"
  subnet_id = module.crazyeats-subnet.subnetid
  instance_type = "t2.micro"
  ami = "ami-02eb7a4783e7e9317"
  instance_name = "jumbox"
  key_name = "crazyeatskp"
  sg = [module.crazyeats-sg.sgid]
  aasociate_public_ip = true
}