# ACM certificates

resource "aws_acm_certificate" "this" {
  provider = aws.cloudfront

  domain_name = var.website[0]

  subject_alternative_names = var.website

  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_route53_record.caa
  ]
}

# - ACM certificates - Validation

resource "aws_acm_certificate_validation" "this" {
  provider = aws.cloudfront

  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [for record in aws_route53_record.dns_validation : record.fqdn]
}
