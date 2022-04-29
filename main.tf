
resource "aws_launch_template" "aws_launch_template" {
  name = local.name
  tags = {
    Name = local.name
  }
  image_id               = "ami-0fb653ca2d3203ac1"//data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [data.aws_security_group.default.id]
  monitoring {
    enabled = true
  }
  user_data  = base64encode(local.userdata)
}

module "create_security_group" {
  source = "./modules/security_group"
  vpc_id = data.aws_vpc.default.id
  ingress=var.ingress


}
module "create_security_rule" {

  for_each          = toset(["22_SSH", "80_HTTP", "443_HTTPS"])
  source            = "./modules/security_rule"
  ports             = each.value
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = data.aws_security_group.default.id
}

resource "tls_private_key" "keypair" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "aws_key_pair" "key_pair" {
  key_name   = "deployer-key"
  public_key = tls_private_key.keypair.public_key_openssh
}

