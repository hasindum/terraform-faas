data "template_file" "user_data" {
  template = "${file("${path.module}/template/user-data.tpl")}"
  vars {
    asg_name_data = "faas-aws-asg"
  }
}

data "aws_ami" "fass" {
  most_recent = "true"

  filter = "${var.ami_filter}"

  owners = ["${var.ami_owners}"]
}

#data "aws_instance" "ec2_faas_instance" {
#  filter {
#    name = "tag:t_environment"
#    values = ["test"]
#  }
#   depends_on = ["aws_autoscaling_group.fass_instance"]
#}
