resource "aws_lb" "ILB" {
    name = var.ILB_name
    load_balancer_type = var.load_balancer_type
    internal = var.ILB_internal
    subnets = var.pvt_subnets
    security_groups = [var.ILB_SG]          
}

resource "aws_lb_target_group" "ILB_TG" {
# Target Group defines the backend servers (backend EC2 instances) 
# and how the ALB sends traffic to them and checks their health.
    vpc_id = var.vpc_id
    name = var.ILB_TG_name
    port = var.ILB_port
# Port defines the application port on the backend EC2 where the ILB forwards traffic.
    protocol = var.ILB_protocol
# Protocol defines how the ILB communicates with the backend EC2 (HTTP or HTTPS).
    target_type = var.ILB_target_type

    health_check {
      path = var.ILB_path
# Path is used by the ILB to perform health checks and confirm the backend application is running.
      protocol = var.ILB_protocol
    } 
}

resource "aws_lb_listener" "ILB_listener" {
# A listener tells the ILB on which port and protocol it should listen for incoming traffic 
# and what action to take when traffic arrives.
    port = var.ILB_port
# Specifies the port on which the ILB listens for incoming requests from frontend services.
    protocol = var.ILB_protocol
# Defines the protocol used by frontend to connect to the ILB
    load_balancer_arn = aws_lb.ILB.id

# default action type Defines what the ILB should do with incoming traffic 
# — usually forward it to a target group.
    default_action {
      target_group_arn = aws_lb_target_group.ILB_TG.id
      type = var.ILB_action_type
    }  
}
