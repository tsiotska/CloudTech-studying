resource "aws_default_vpc" "default_vpc" {}

resource "aws_default_subnet" "default_subnet_a" {
  availability_zone = "${module.aws_module.region}a"
}

resource "aws_default_subnet" "default_subnet_b" {
  availability_zone = "${module.aws_module.region}b"
}

resource "aws_default_subnet" "default_subnet_c" {
  availability_zone = "${module.aws_module.region}c"
}