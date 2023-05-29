variable "vpcid" {
  type = string
}

variable "sgname" {
  type = string
}

variable "ingresscidr" {
  type = list(string)
}

variable "fromport" {
  type = number
}

variable "toport" {
  type = number
}

variable "protocol" {
  type = string
}