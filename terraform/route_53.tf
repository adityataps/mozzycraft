resource "aws_route53_record" "mc" {
  zone_id = var.route_53_zone_id
  name    = "mc.${var.domain_name}"
  type    = "A"
  ttl     = 172800
  records = [aws_instance.mozzy_craft_ec2.public_ip]
}
