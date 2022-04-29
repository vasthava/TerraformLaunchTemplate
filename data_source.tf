data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/ubuntu-*-*-amd64-server-*"]
  }
  owners = ["099720109477"] //cannonical

}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "public_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  filter {
    name   = "tag:Name"
    values = ["default"]
  }

}
data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
  filter {
    name="tag:Name"
    values=["default"]
  }
}