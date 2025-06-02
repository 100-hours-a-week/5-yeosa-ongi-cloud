resource "google_compute_backend_bucket" "cdn_backend" {
  name        = var.backend_bucket_name
  bucket_name = var.bucket_name
  enable_cdn  = true
}

resource "google_compute_url_map" "cdn_url_map" {
  name            = var.url_map_name
  default_service = google_compute_backend_bucket.cdn_backend.self_link
}

resource "google_compute_managed_ssl_certificate" "cdn_cert" {
  name = "cdn-cert"

  managed {
    domains = [var.domain] # 예: ["cdn.ongi.today"]
  }
}

resource "google_compute_target_http_proxy" "cdn_http_proxy" {
  name    = var.http_proxy_name
  url_map = google_compute_url_map.cdn_url_map.id
}

resource "google_compute_target_https_proxy" "cdn_https_proxy" {
  name             = var.https_proxy_name
  url_map          = google_compute_url_map.cdn_url_map.self_link
  ssl_certificates = [google_compute_managed_ssl_certificate.cdn_cert.id]
}

resource "google_compute_global_address" "cdn_ip" {
  name = var.cdn_ip_address_name
}

resource "google_compute_global_forwarding_rule" "cdn_forwarding_rule" {
  name                  = "${var.forwarding_rule_name}-http"
  target                = google_compute_target_http_proxy.cdn_http_proxy.self_link
  port_range            = "80"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  ip_address            = google_compute_global_address.cdn_ip.address
}

resource "google_compute_global_forwarding_rule" "https_forwarding_rule" {
  name       = "${var.forwarding_rule_name}-https"
  port_range = "443"
  target     = google_compute_target_https_proxy.cdn_https_proxy.self_link
  ip_address = google_compute_global_address.cdn_ip.address
}