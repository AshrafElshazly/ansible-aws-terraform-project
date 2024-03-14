variable "ami" {
  type    = string
  default = "ami-07d9b9ddc6cd8dd30"
}

variable "instance_type" {
  type    = string
  default = "t2.medium"
}

variable "key_name" {
  type    = string
  default = "vockey"
}

variable "region" {
  default = "us-east-1"
}
