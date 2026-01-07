resource "aws_autoscaling_group" "Frontend_ASG" {
    name = var.Frontend_ASG_name
    min_size = var.min_size
    max_size = var.max_size
    desired_capacity = var.desired_capacity
    vpc_zone_identifier = var.pub_subnets
# defines the subnets and Availability Zones where ASG should launch instances.
    health_check_type = var.health_check_type
# ELB health check verifies that the application is actually working, not just that EC2 is running.
# this ensures ASG to replace instances when the application fails, not just when EC2 stops.
    target_group_arns = [var.Frontend_TG_arn]

    launch_template {
        id = var.Frontend_LT_id
        version = var.ASG_version
    }  
}

resource "aws_autoscaling_group" "Backend_ASG" {
    name = var.Backend_ASG_name
    min_size = var.min_size
    max_size = var.max_size
    desired_capacity = var.desired_capacity
    health_check_type = var.health_check_type
    target_group_arns = [var.Backend_TG_arn]
    vpc_zone_identifier = var.pvt_subnets

    launch_template {
      id = var.Backend_LT_id
      version = var.ASG_version
    }  
}
