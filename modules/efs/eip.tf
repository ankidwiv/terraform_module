resource "aws_eip" "Nat_eip" {
  count = "${length(var.Private_subnet_cidrs)}"
  vpc   = "true"

  tags {
    Name = "Nat_EIP-${count.index +1}"
  }
}
