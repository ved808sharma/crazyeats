terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
  access_key = "AKIAT4EDDZXUGSKWEO77"
  secret_key = "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"
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

module "crazyeats-sg" {
  source = "../modules/services/network/sg"
  sgname = "crazyeats-sg"
  vpcid = module.crazyeats-vpc.vpcid
  fromport = 22
  toport =  22
  ingresscidr = ["0.0.0.0/0"]
  protocol = "tcp"
}

module "crazyeats-kp" {
  source = "../modules/services/compute/keypair"
  keyname = "crazyeatskp"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDrzlSu4wDX/dTHVvgWYbDh/8YsEJ/BmDxQjqx36/7j5yEi2sC3cLA1F4UVbxOpb2N/PkUJuk29cHkqxH8juLWX8l3eYDUt0kdqf1CNm4p8zuCMd2HKucCp3ZQ7QqYRiFTgU8pGb+IRY//fmIMoHpoFEovkiOULefFAuUdVBbQLnhd+S4UmBHQEDo+Jw4nTbO4DPKfrrQfRMMJPj598lo9XBFc/DXSCJFHFlNAAnq4XKM4CBGcHhaFFQJ67x59Uvi3WK8uFZtdQSrHp+DEvM/2vgW3TRpcjE5AFqoVxv+8EvuK6T6oBgOynMN+vSKN4ZMU4QYD0oQziK/Q1KJYe729ILFoAsjA582pM1Q3XCsQPPGpCRs9VTBk8axtDPpP3M5q533jLFWq9NKr7iIT79TG4Sg6XB9Ci4qB+Xe57ILVo6MXz1/9o7f0Ac6ASXnykGLHOxSX1kIVBe6NSzn62INP14ccwxG6916RJ9ByiuKF079DjMBVN8wqyF4wg0xODTNU= ved@Vedprakashs-MacBook-Air.local"
}

module "crazyeats-ec2" {
  source = "../modules/services/compute/ec2"
  subnet_id = module.crazyeats-subnet.subnetid
  instance_type = "t2.micro"
  ami = "ami-02eb7a4783e7e9317"
  instance_name = "jumbox"
  key_name = module.crazyeats-kp.keyname
  sg = [module.crazyeats-sg.sgid]
  aasociate_public_ip = true
}