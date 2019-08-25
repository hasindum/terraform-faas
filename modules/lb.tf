# Network Load Balancer for apiservers and ingress
resource "aws_lb" "nlb" {
  name               = "fass-nlb"
  load_balancer_type = "network"
  internal           = false

  subnets = ["${var.subnet_ids_fass}"]

  enable_cross_zone_load_balancing = true
}

resource "aws_lb_listener" "apiserver-https" {
  load_balancer_arn = "${aws_lb.nlb.arn}"
  protocol          = "TCP"
  port              = "80"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.controllers.arn}"
  }
}


# Target group of controllers
resource "aws_lb_target_group" "controllers" {
  name        = "faas-controllers"
  vpc_id      = "${var.vpc_id}"
  target_type = "instance"

  protocol = "TCP"
  port     = 8080

  # TCP health check for apiserver
  health_check {
    protocol = "TCP"
    port     = 8080

    # NLBs required to use same healthy and unhealthy thresholds
    healthy_threshold   = 3
    unhealthy_threshold = 3

    # Interval between health checks required to be 10 or 30
    interval = 10
  }
}

# Attach controller instances to apiserver NLB
#resource "aws_lb_target_group_attachment" "controllers" {
#  count = "1"

#  target_group_arn = "${aws_lb_target_group.controllers.arn}"
#  target_id        = "${data.aws_instance.ec2_faas_instance.id[count.index]}"
#  port             = 8080
#}