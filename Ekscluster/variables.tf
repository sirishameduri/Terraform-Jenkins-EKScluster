variable "vpc_cidr" {
    description = "vpc values"
    type = string
  
}

variable "public_subnets" {
    description = "subnet values"
    type = list(string)
  
}
variable "private_subnets" {
    description = "subnet values"
    type = list(string)
}