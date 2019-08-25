resource "aws_security_group" "fass" {
  name_prefix = "${var.environment}-security-group"
  vpc_id      = "${var.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {

    from_port   = 2377
    to_port     = 2377
    protocol    = "tcp"
    cidr_blocks = ["10.1.0.0/16"]

  }

  tags = "${merge(local.tags, map("Name", format("%s", local.name_sg)))}"
}

resource "aws_security_group_rule" "runner_ssh" {
  count = "${var.enable_fass_ssh_access ? 1 : 0}"

  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["${var.fass_ssh_cidr_blocks}"]

  security_group_id = "${aws_security_group.fass.id}"
}

resource "aws_security_group" "docker_machine" {
  name_prefix = "${var.environment}-docker-machine"
  vpc_id      = "${var.vpc_id}"

  tags = "${merge(local.tags, map("Name", format("%s", local.name_sg)))}"
}

resource "aws_security_group_rule" "docker" {
  type        = "ingress"
  from_port   = 2376
  to_port     = 2376
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.docker_machine.id}"
}

resource "aws_security_group_rule" "ssh" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.docker_machine.id}"
}

resource "aws_security_group_rule" "out_all" {
  type        = "egress"
  from_port   = 0
  to_port     = 65535
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.docker_machine.id}"
}
