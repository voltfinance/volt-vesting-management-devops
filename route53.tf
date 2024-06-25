# Route53

# CAA

# Note: if you'll need to use a subdomain first create a CAA record

resource "aws_route53_record" "caa" {

  for_each = toset(var.website)

  provider = aws.dns

  zone_id = data.aws_route53_zone.selected.zone_id
  name    = each.key
  type    = "CAA"
  ttl     = 300
  records = ["0 issue \"amazonaws.com\""]
}

# CNAME - DNS validation

resource "aws_route53_record" "dns_validation" {
  provider = aws.dns

  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.selected.zone_id
}

# A

resource "aws_route53_record" "a" {

  for_each = toset(var.website)

  provider = aws.dns

  zone_id = data.aws_route53_zone.selected.zone_id
  name    = each.key
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = false
  }
}
