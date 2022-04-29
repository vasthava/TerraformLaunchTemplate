resource "aws_security_group" "allow_web" {
  
  name = "VPC"
  description = "test_scg"
  vpc_id = var.vpc_id
  dynamic "ingress"{
      for_each=var.ingress
      content{
          cidr_blocks=lookup(ingress.value,"cidr_blocks",null)
           description=lookup(ingress.value,"description",null)
            from_port=lookup(ingress.value,"from_port",0)
              to_port=lookup(ingress.value,"to_port",0)
             protocol=lookup(ingress.value,"protocol",null)
      }
  }
  egress{
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]

  }
}

