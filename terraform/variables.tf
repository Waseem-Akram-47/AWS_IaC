variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["172.16.0.0/24", "172.16.1.0/24", "172.16.2.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["172.16.3.0/24", "172.16.4.0/24", "172.16.5.0/24"]
}
