resource "aws_lb" "nlb" {
  name               = "fass-nlb"
  load_balancer_type = "network"
  internal           = false

  subnets = ["${var.subnet_ids_fass}"]

  enable_cross_zone_load_balancing = true
}

resource "aws_lb_listener" "faas-https" {
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

  # TCP health check for faas
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

resource "aws_lb_listener" "faas-grafana-https" {
  load_balancer_arn = "${aws_lb.nlb.arn}"
  protocol          = "TCP"
  port              = "8080"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.controllers-grafana.arn}"
  }
}


# Target group of controllers
resource "aws_lb_target_group" "controllers-grafana" {
  name        = "faas-controllers-grafana"
  vpc_id      = "${var.vpc_id}"
  target_type = "instance"

  protocol = "TCP"
  port     = 3000

  # TCP health check for faas
  health_check {
    protocol = "TCP"
    port     = 3000

    # NLBs required to use same healthy and unhealthy thresholds
    healthy_threshold   = 3
    unhealthy_threshold = 3

    # Interval between health checks required to be 10 or 30
    interval = 10
  }
}