variable "ami_id" {
  type    = string
  default = "ami-0c02fb55956c7d316" # Amazon Linux 2, us-east-1
}

variable "instance_type" {
  type    = string
  default = "t3.micro"              # Free Tier eligible
}

variable "subnet_id" {
  type = string
}

variable "security_group" {
  type = string
}
