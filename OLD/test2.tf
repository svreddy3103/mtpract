/*
1) Create Ec2 Instance
2) Create EIP
3) Attach EIP to ec2 Instance
*/

resource aws_instance "i1"{
	ami="ami-0801a1e12f4a9ccc0"
	instance_type="t2.micro"
	subnet_id="subnet-0e13901261f18822"
}
resource aws_eip "myeip"{
    depends_on=[aws_instance.i1]
}

resource aws_eip_association "sheshi"{
	instance_id=aws_instance.i1.id
	allocation_id = aws_eip.myeip.id
}