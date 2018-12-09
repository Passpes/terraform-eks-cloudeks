#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "cloudeks" {
  cidr_block = "${var.vpc_cidr}"

  tags = "${
    map(
     "Name", "terraform-eks-cloudeks-node",
     "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}

resource "aws_subnet" "cloudeks" {
  count = 2

  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = "${aws_vpc.cloudeks.id}"

  tags = "${
    map(
     "Name", "terraform-eks-cloudeks-node",
     "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}

resource "aws_internet_gateway" "cloudeks" {
  vpc_id = "${aws_vpc.cloudeks.id}"

  tags {
    Name = "terraform-eks-cloudeks"
  }
}

resource "aws_route_table" "cloudeks" {
  vpc_id = "${aws_vpc.cloudeks.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.cloudeks.id}"
  }
}

resource "aws_route_table_association" "cloudeks" {
  count = 2

  subnet_id      = "${aws_subnet.cloudeks.*.id[count.index]}"
  route_table_id = "${aws_route_table.cloudeks.id}"
}

