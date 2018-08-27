resource "aws_route_table" "public_route" {
  vpc_id = "${aws_vpc.My_Vpc.id}"
  count  = "${length(var.Public_subnet_cidrs)}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.My_IGW.id}"
  }

  tags {
    Name = "Public_route-${count.index +1}"
  }
}

resource "aws_route_table" "Private_route" {
  vpc_id = "${aws_vpc.My_Vpc.id}"
  count  = "${length(var.Private_subnet_cidrs)}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${element(aws_nat_gateway.Nat_gateway.*.id, count.index)}"
  }

  tags {
    Name = "Private_route-${count.index +1}"
  }
}

resource "aws_route_table_association" "Public_route_association" {
  count          = "${length(var.Public_subnet_cidrs)}"
  subnet_id      = "${element(aws_subnet.Public_subnet.*.id, count.index%length(var.Public_subnet_cidrs))}"
  route_table_id = "${element(aws_route_table.public_route.*.id, count.index%length(var.Public_subnet_cidrs))}"
}

resource "aws_route_table_association" "Private_route_association" {
  count          = "${length(var.Private_subnet_cidrs)}"
  subnet_id      = "${element(aws_subnet.Private_subnet.*.id, count.index%length(var.Private_subnet_cidrs))}"
  route_table_id = "${element(aws_route_table.Private_route.*.id, count.index%length(var.Private_subnet_cidrs))}"
}
