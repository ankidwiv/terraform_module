variable "aws_region" {
  default = "us-east-1"
}

#Variable for VPC
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

# variable for subnet
variable "Public_subnet_cidrs" {
  type = "list"

  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "Private_subnet_cidrs" {
  type    = "list"
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "AZ" {
  type    = "list"
  default = ["us-east-1a", "us-east-1b"]
}

variable "instance_count" {
  default = 2
}

variable "ami" {
  default = "ami-6871a115"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ssh_key" {
  default = "My-us-east-key"
}
