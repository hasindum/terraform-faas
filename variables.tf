variable "aws_region" {
  description = "AWS region."
  type        = "string"
  default     = "eu-west-1"
}

variable "environment" {
  description = "A name that identifies the environment, will used as prefix and for tagging."
  default     = "fass-docker"
  type        = "string"
}

variable "public_ssh_key_filename" {
  default = "generated/id_rsa.pub"
}

variable "private_ssh_key_filename" {
  default = "generated/id_rsa"
}

variable "runner_name" {
  description = "Name of the fasss"
  type        = "string"
  default     = "docker"
}
