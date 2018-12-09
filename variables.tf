variable "region" {
  default="us-east-1"
}

variable "aws_access_key" {
  default = ""
}

variable "aws_secret_key" {
  default = ""
}

variable "cluster-name" {
  default = "terraform-eks-cloudeks"
  type    = "string"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
