module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.59.0"

  name = "vpc-${var.environment}"
  cidr = "10.1.0.0/16"

  azs                = ["eu-west-1a"]
  public_subnets     = ["10.1.101.0/24"]
  enable_s3_endpoint = false

  tags = {
    Environment = "${var.environment}"
  }
}

module "faas" {
  source = "modules"

  aws_region  = "${var.aws_region}"
  environment = "${var.environment}"

  ssh_public_key = "${local_file.public_ssh_key.content}"

  vpc_id                   = "${module.vpc.vpc_id}"
  subnet_ids_fass = "${module.vpc.public_subnets}"
  subnet_id_runners       = "${element(module.vpc.public_subnets, 0)}"

}
