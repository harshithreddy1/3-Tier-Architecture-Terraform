resource "aws_launch_template" "Frontend_LT" {
    name = var.Frontend_LT_name
    update_default_version = var.LT_version
    image_id = var.ami_id
    instance_type = var.LT_instance_type
    key_name = var.key_pair_name
    vpc_security_group_ids = [var.Frontend_LT_SG]
    user_data = base64encode(file("${path.module}/pub_userdata.sh"))
# Base64encode converts data into a safe text format so it can be transmitted and processed without errors. EC2 API accepts user data only in Base64 format.
# file("   ") reads the content of a file and returns it as a string to Terraform.
# $ is used to replace a variable or expression with its actual value inside a string.
# {path.module} gives the absolute path of the current Terraform module directory.

    tag_specifications {
      resource_type = var.LT_resource_type
      tags = {
        Name = var.Frontend_ec2_name
      }
    }
}
# resource_type tells AWS which resource should receive the tags when an instance is launched using the Launch Template.
# EX, for instance or EBS volumes or network interfaces etc..

resource "aws_launch_template" "Backend_LT" {
    name = var.Backend_LT_name
    update_default_version = var.LT_version
    instance_type = var.LT_instance_type
    key_name = var.key_pair_name
    image_id = var.ami_id
    vpc_security_group_ids = [var.Backend_LT_SG]
    user_data = base64encode(file("${path.module}/pvt_userdata.sh"))

    tag_specifications {
      resource_type = var.LT_resource_type
      tags = {
        Name = var.Backend_ec2_name
      }
    }  
}
