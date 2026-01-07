resource "aws_lb" "ALB" {
    name = var.ALB_name
    internal = var.ALB_internal
    load_balancer_type = var.ALB_load_balancer_type
    subnets = var.pub_subnets
# Subnets tell AWS where to place the load balancer so it can receive traffic.
    security_groups = [var.ALB_SG]
}

resource "aws_lb_target_group" "ALB_TG" {
# Target Group defines the backend servers (frontend EC2 instances) 
# and how the ALB sends traffic to them and checks their health.
    name = var.ALB_TG_name
    vpc_id = var.vpc_id
    port = var.ALB_TG_port
# Port defines the application port on the frontend EC2 where the ALB forwards traffic.
    protocol = var.ALB_TG_protocol
# Protocol defines how the ALB communicates with the frontend EC2 (HTTP or HTTPS).
    target_type = var.ALB_TG_target_type

    health_check {
      path = var.ALB_TG_path
# Path is used by the ALB to perform health checks and confirm the frontend application is running.
      protocol = var.ALB_TG_protocol
    }
}

resource "aws_lb_listener" "ALB_listener" {
# A listener tells the ALB on which port and protocol it should listen for incoming traffic 
# and what action to take when traffic arrives.
    load_balancer_arn = aws_lb.ALB.id
    port = var.ALB_TG_port
# Specifies the port on which the ALB listens for client requests
    protocol = var.ALB_TG_protocol
#Defines the protocol used by clients to connect to the ALB

# default action type Defines what the ALB should do with incoming traffic 
# — usually forward it to a target group.
    default_action {
      type = var.ALB_action_type
      target_group_arn = aws_lb_target_group.ALB_TG.arn
    } 
}
