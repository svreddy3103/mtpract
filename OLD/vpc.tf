resource aws_vpc "vpc1"{
	cidr_block="10.0.0.0/24"
	tags={
		"Name"="myvpc1"
	}
}
resource aws_subnet "sn1"{
	vpc_id=aws_vpc.vpc1.id
	cidr_block="10.0.0.0/25"
	availability_zone="ap-south-1a"
	tags={
		"Name"="myvpc1-sn1"
	}
}
resource aws_subnet "sn2"{
	vpc_id=aws_vpc.vpc1.id
	cidr_block="10.0.0.128/25"
	availability_zone="ap-south-1b"
	tags={
		"Name"="myvpc1-sn2"
	}
}
