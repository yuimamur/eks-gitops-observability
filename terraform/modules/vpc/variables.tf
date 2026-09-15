variable "name" {
  type = string
}

variable "cidr" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "single_nat_gateway" {
  type    = bool
  default = true
}
