output "nlb_dns" {
  value       = "${aws_lb.nlb.dns_name}"
  description = "The ID of the VPC"
}