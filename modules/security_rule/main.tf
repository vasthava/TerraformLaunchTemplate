resource "aws_security_group_rule" "ssh_rule" {
 # for_each = toset([ "22","80" ])
  type              = "ingress"
  from_port         = local.start_port
  to_port           = local.start_port
  protocol          = "tcp"
  cidr_blocks       = var.cidr_blocks
  security_group_id =var.security_group_id
  description = local.description
}
locals {
  ports = split("_",var.ports)
  start_port =local.ports[0]
  description = local.ports[1]
}