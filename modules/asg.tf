resource "aws_autoscaling_group" "fass_instance" {
  name                = "faas-aws-asg"
  vpc_zone_identifier = ["${var.subnet_ids_fass}"]

  min_size                  = "2"
  max_size                  = "2"
  desired_capacity          = "2"
  health_check_grace_period = 0
  launch_configuration      = "${aws_launch_configuration.fass_instance.name}"
  target_group_arns = ["${aws_lb_target_group.controllers.arn}","${aws_lb_target_group.controllers-grafana.arn}"]
  tags = [
    "${concat(
        data.null_data_source.tags.*.outputs,
        list(map("key", "Name", "value", local.name_runner_instance, "propagate_at_launch", true)))}",
  ]
}

resource "aws_launch_configuration" "fass_instance" {
  security_groups      = ["${aws_security_group.fass.id}"]
  key_name             = "${aws_key_pair.key.key_name}"
  image_id             = "${data.aws_ami.fass.id}"
  user_data            = "${data.template_file.user_data.rendered}"
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.instance.name}"

  associate_public_ip_address = false

  lifecycle {
    create_before_destroy = true
  }
}
