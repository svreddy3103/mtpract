/*
resource aws_instance "i1"{
	ami="ami-0801a1e12f4a9ccc0"
	instance_type="t2.micro"
	subnet_id="subnet-0e13901261f188221"
}

resource aws_ebs_volume "v1"{
	size="5"
	availability_zone=aws_instance.i1.availability_zone
	type="gp2"
}
resource aws_volume_attachment "i1v1"{
	instance_id=aws_instance.i1.id
	volume_id=aws_ebs_volume.v1.id
	device_name="/dev/sdf"
}

output "snid"{
	value=aws_instance.i1.subnet_id
}
output "azname"{
	value=aws_instance.i1.availability_zone
}
*/