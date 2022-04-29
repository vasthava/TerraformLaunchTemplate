variable "ingress" {
  description = "Inbound ports to be open"
  default = [
    {
      from_port = 22
      to_port = 22
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
      description = "SSH Port"
    },
    {
      from_port = 80
      to_port = 80
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTP"
    }
    ,
    {
      from_port = 443
      to_port = 443
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTPS"
    }
  ]
}