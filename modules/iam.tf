resource "aws_iam_instance_profile" "instance" {
  name = "${var.environment}-instance-profile"
  role = "${aws_iam_role.instance.name}"
}

data "template_file" "instance_role_trust_policy" {
  template = "${length(var.instance_role_json) > 0 ? var.instance_role_json : file("${path.module}/policies/instance-role-trust-policy.json")}"
}

data "template_file" "instance_docker_machine_policy" {
  template = "${file("${path.module}/policies/instance-docker-machine-policy.json")}"
}

data "template_file" "dockermachine_role_trust_policy" {
  template = "${file("${path.module}/policies/instance-role-trust-policy.json")}"
}

resource "aws_iam_role" "instance" {
  name               = "${var.environment}-instance-role"
  assume_role_policy = "${data.template_file.instance_role_trust_policy.rendered}"
}  

resource "aws_iam_role" "docker_machine" {
  name               = "${var.environment}-docker-machine-role"
  assume_role_policy = "${data.template_file.dockermachine_role_trust_policy.rendered}"
}

resource "aws_iam_instance_profile" "docker_machine" {
  name = "${var.environment}-docker-machine-profile"
  role = "${aws_iam_role.docker_machine.name}"
}

resource "aws_iam_policy" "instance_docker_machine_policy" {
  name        = "${var.environment}-docker-machine"
  path        = "/"
  description = "Policy for docker machine."

  policy = "${data.template_file.instance_docker_machine_policy.rendered}"
}

resource "aws_iam_role_policy_attachment" "instance_docker_machine_policy" {
  role       = "${aws_iam_role.instance.name}"
  policy_arn = "${aws_iam_policy.instance_docker_machine_policy.arn}"
}