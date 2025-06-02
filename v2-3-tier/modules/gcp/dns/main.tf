resource "google_dns_managed_zone" "zone" {
  name        = var.zone_name
  dns_name    = "${var.domain_name}."
  description = "DNS zone for ${var.domain_name}"
  visibility  = "public"
}

resource "google_dns_record_set" "a_record" {
  name         = "${var.subdomain}.${var.domain_name}."
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.zone.name

  rrdatas = [var.ip_address]
}
