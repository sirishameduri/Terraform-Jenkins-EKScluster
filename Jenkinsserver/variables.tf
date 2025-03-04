variable "vpc_cidr" {
  description = "vpc value"
  type        = string

}
variable "public_subnets" {
  description = "subnet cidr"
  type        = list(string)

}
variable "ec2_instance" {
  description = "ec2-instance"
  type = string
}