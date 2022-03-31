/*
1) Create a VPC
2) Create  one public and one private in each AZ
3) Create NAT and attach to Private Subnets
4) Create Clasic ELB in Public SN
5) Launch Ec2 Instance in Each Private Subnet and attach ELB 

Note: Install apache2 in all ec2 Instances

*/

// create a vpc
resource aws_vpc "vpc1"{
	cidr_block="10.0.0.0/16"
	tags={
		"Name"="myvpc1"
	}
}
// creating Subnets 
resource aws_subnet "sn1"{
	cidr_block="10.0.0.0/24"
	vpc_id=aws_vpc.vpc1.id
	availability_zone="ap-southeast-1a"
	map_public_ip_on_launch="true"
	tags={
		"Name"="SN1"
	}
}
resource aws_subnet "sn2"{
	cidr_block="10.0.1.0/24"
	vpc_id=aws_vpc.vpc1.id
	availability_zone="ap-southeast-1b"
	tags={
		"Name"="Sn2"
	}
}
resource aws_subnet "sn3"{
	cidr_block="10.0.2.0/24"
	vpc_id=aws_vpc.vpc1.id
	availability_zone="ap-southeast-1c"
	tags={
		"Name"="Sn3"
	}
}
resource aws_subnet "sn4"{
	cidr_block="10.0.3.0/24"
	vpc_id=aws_vpc.vpc1.id
	availability_zone="ap-southeast-1a"
	map_public_ip_on_launch="true"
	tags={
		"Name"="SN4"
	}
}
resource aws_subnet "sn5"{
	cidr_block="10.0.4.0/24"
	vpc_id=aws_vpc.vpc1.id
	availability_zone="ap-southeast-1b"
	tags={
		"Name"="Sn5"
	}
}
resource aws_subnet "sn6"{
	cidr_block="10.0.5.0/24"
	vpc_id=aws_vpc.vpc1.id
	availability_zone="ap-southeast-1c"
	tags={
		"Name"="Sn6"
	}
}

// creating & attaching igw to vpc
resource aws_internet_gateway "igw1"{
	vpc_id=aws_vpc.vpc1.id
	tags={
		"Name"="myvpc1-igw"
	}
}
// creating RT for Public Subnet i.e Sn1
resource aws_route_table "rt1"{
    vpc_id=aws_vpc.vpc1.id	
	route{
		cidr_block="0.0.0.0/0"
		gateway_id=aws_internet_gateway.igw1.id
	}
}
// map rt to sn1
resource aws_route_table_association "sn1rt1"{
	subnet_id =aws_subnet.sn1.id
	route_table_id =aws_route_table.rt1.id
}
resource aws_route_table_association "sn2rt1"{
	subnet_id =aws_subnet.sn2.id
	route_table_id =aws_route_table.rt1.id
}
resource aws_route_table_association "sn3rt1"{
	subnet_id =aws_subnet.sn3.id
	route_table_id =aws_route_table.rt1.id
}

// Create EIP For NAT

resource aws_eip "nateip"{
}

resource aws_nat_gateway "nat"{
	subnet_id     =aws_subnet.sn1.id
	allocation_id=aws_eip.nateip.id
}

// creating RT for Private Subnet i.e Sn4,sn5,sn6
resource aws_route_table "rt2"{
    vpc_id=aws_vpc.vpc1.id	
	route{
		cidr_block="0.0.0.0/0"
		nat_gateway_id=aws_nat_gateway.nat.id
	}
}

resource aws_route_table_association "sn4rt2"{
	subnet_id =aws_subnet.sn4.id
	route_table_id =aws_route_table.rt2.id
}

resource aws_route_table_association "sn5rt2"{
	subnet_id =aws_subnet.sn5.id
	route_table_id =aws_route_table.rt2.id
}
resource aws_route_table_association "sn6rt2"{
	subnet_id =aws_subnet.sn6.id
	route_table_id =aws_route_table.rt2.id
}




