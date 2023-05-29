variable "subnet_id" {
  type = string
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "aasociate_public_ip" {
  type = bool
}

variable "key_name" {
  type = string
}

variable "sg" {
  type = list(string)
}

variable "instance_name" {
  type = string
}

