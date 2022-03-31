resource aws_elb "myelb"{
	name="testelb1"
	subnets=[aws_subnet.sn1.id,aws_subnet.sn2.id,aws_subnet.sn3.id]
	listener{
		instance_port="80"
		instance_protocol="http"
		lb_port="80"
		lb_protocol="http"
	}
}
// create sg for ec2 instances  ib 80, ob 80,443
resource aws_security_group "sg1" {
  vpc_id =aws_vpc.vpc1.id
  name        ="tfsg"
  description ="tfsg"
	
}
// Ingress Rules
 resource "aws_security_group_rule" "rule1"{
   security_group_id =aws_security_group.sg1.id
   type              = "ingress"
   from_port         = "80"
  to_port           = "80"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

 }
 
 resource "aws_security_group_rule" "rule4"{
   security_group_id =aws_security_group.sg1.id
   type              = "egress"
   from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]

 }
 
resource aws_instance "i1"{
    ami="ami-055d15d9cfddf7bd3"
	instance_type="t2.micro"
	subnet_id= aws_subnet.sn4.id
	vpc_security_group_ids=[aws_security_group.sg1.id]
	user_data=file("./1.sh")
}
resource aws_instance "i2"{
    ami="ami-055d15d9cfddf7bd3"
	instance_type="t2.micro"
	subnet_id= aws_subnet.sn5.id
	vpc_security_group_ids=[aws_security_group.sg1.id]
	user_data=<<-EOF
	#!/bin/bash
	apt-get update
	apt-get install apache2 -y
	EOF
}

resource "aws_elb_attachment" "myelb-i1" {
  elb      = aws_elb.myelb.id
  instance = aws_instance.i1.id
}
resource "aws_elb_attachment" "myelb-i2" {
  elb      = aws_elb.myelb.id
  instance = aws_instance.i2.id
}

output "elb_name"{
	value=aws_elb.myelb.dns_name
}