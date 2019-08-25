resource "aws_key_pair" "key" {
  key_name   = "${var.environment}-fass"
  public_key = "${var.ssh_public_key}"
}
