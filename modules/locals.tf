locals {
  // custom names for instances and security groups
  name_runner_instance = "${var.overrides["name_runner_agent_instance"] == "" ? local.tags["Name"] : var.overrides["name_runner_agent_instance"]}"
  name_sg              = "${var.overrides["name_sg"] == "" ? local.tags["Name"] : var.overrides["name_sg"]}"
}
