variable "aws_region" {
  description = "AWS region."
  type        = "string"
}

variable "environment" {
  description = "A name that identifies the environment, used as prefix and for tagging."
  type        = "string"
}

variable "vpc_id" {
  description = "The target VPC for the docker-machine and runner instances."
  type        = "string"
}

variable "subnet_id_runners" {
  description = "List of subnets used for hosting the fasss."
  type        = "string"
}

variable "subnet_ids_fass" {
  description = "Subnet used for hosting the GitLab runner."
  type        = "list"
}

variable "instance_type" {
  description = "Instance type used for the GitLab runner."
  type        = "string"
  default     = "m4.large"
}


variable "ssh_public_key" {
  description = "Public SSH key used for the GitLab runner EC2 instance."
  type        = "string"
}

variable "docker_machine_instance_type" {
  description = "Instance type used for the instances hosting docker-machine."
  default     = "m5.large"
}

variable "enable_fass_ssh_access" {
  description = "Enables SSH Access to the instance."
  default     = false
}

variable "fass_ssh_cidr_blocks" {
  description = "List of CIDR blocks to allow SSH Access from to the instance."
  type        = "list"
  default     = ["0.0.0.0/0"]
}


variable "tags" {
  type        = "map"
  description = "Map of tags that will be added to created resources. By default resources will be tagged with name and environment."
  default     = {}
}


variable "instance_role_json" {
  description = "Docker machine runner instance override policy, expected to be in JSON format."
  type        = "string"
  default     = ""
}

variable "instance_role_runner_json" {
  description = "Instance role json for the docker machine runners to override the default."
  type        = "string"
  default     = ""
}

variable "ami_filter" {
  description = "List of maps used to create the AMI filter for the Gitlab runner agent AMI. Currently Amazon Linux 2 `amzn2-ami-hvm-2.0.????????-x86_64-ebs` looks to *not* be working for this configuration."
  type        = "list"

  default = [{
    name   = "name"
    values = ["amzn-ami-hvm-2018.03*-x86_64-ebs"]
  }]
}

variable "ami_owners" {
  description = "The list of owners used to select the AMI of Gitlab runner agent instances."
  type        = "list"
  default     = ["amazon"]
}

variable "overrides" {
  description = "This maps provides the possibility to override some defaults. The following attributes are supported: `name_sg` overwrite the `Name` tag for all security groups created by this module. `name_runner_agent_instance` override the `Name` tag for the ec2 instance defined in the auto launch configuration. `name_docker_machine_runners` ovverrid the `Name` tag spot instances created by the runner agent."
  type        = "map"

  default = {
    name_sg                     = ""
    name_runner_agent_instance  = ""
    name_docker_machine_runners = ""
  }
}