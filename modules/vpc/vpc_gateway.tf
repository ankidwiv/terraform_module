#Creating VPC
resource "aws_vpc" "My_Vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = 1
  enable_dns_hostnames = 1

  tags {
    name = "My_Vpc"
  }
}

# Creating IGW for Public route table 

resource "aws_internet_gateway" "My_IGW" {
  vpc_id = "${aws_vpc.My_Vpc.id}"

  tags {
    Name = "My_IGW"
  }
}

# Creating Natgateway for private route table 

resource "aws_nat_gateway" "Nat_gateway" {
  count         = "${length(var.Private_subnet_cidrs)}"
  allocation_id = "${element(aws_eip.Nat_eip.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.Private_subnet.*.id, count.index)}"

  tags {
    Name = "Nat-gateway-${count.index +1}"
  }
}
