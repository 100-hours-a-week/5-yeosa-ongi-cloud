resource "google_compute_backend_bucket" "cdn_backend" {
  name        = "${var.cdn_name}-cdn-backend"
  bucket_name = var.bucket_name
  enable_cdn  = true
}

resource "google_compute_backend_service" "backend_service" {
  name          = "${var.backend_name}-service"
  protocol      = "HTTP"
  port_name     = "http"
  timeout_sec   = 30
  health_checks = [google_compute_health_check.hc.self_link]
  backend {
    group = var.instance_group
  }
}

resource "google_compute_url_map" "cdn_url_map" {
  name            = "${var.cdn_name}-url-map"
  default_service = google_compute_backend_bucket.cdn_backend.self_link
  path_matcher {
    name            = "routing"
    default_service = google_compute_backend_bucket.cdn_backend.self_link

    path_rule {
      paths   = [var.api_path_prefix] 
      service = google_compute_backend_service.backend_service.self_link
    }

    path_rule {
      paths   = [var.static_path_prefix] 
      service = google_compute_backend_service.backend_service.self_link
    }
  }

  host_rule {
    hosts        = ["*"]
    path_matcher = "routing"
  }
}

resource "google_compute_managed_ssl_certificate" "cdn_cert" {
  name = "cdn-cert"
  managed {
    domains = [var.domain] # 예: ["cdn.ongi.today"]
  }
}

resource "google_compute_target_http_proxy" "cdn_http_proxy" {
  name    = "${var.cdn_name}-http-proxy"
  url_map = google_compute_url_map.cdn_url_map.id
}

resource "google_compute_target_https_proxy" "cdn_https_proxy" {
  name             = "${var.cdn_name}-https-proxy"
  url_map          = google_compute_url_map.cdn_url_map.self_link
  ssl_certificates = [google_compute_managed_ssl_certificate.cdn_cert.id]
}

resource "google_compute_global_address" "cdn_ip" {
  name = "${var.cdn_name}-ip"
}

resource "google_compute_global_forwarding_rule" "cdn_forwarding_rule" {
  name                  = "${var.cdn_name}-forwarding-rule-http"
  target                = google_compute_target_http_proxy.cdn_http_proxy.self_link
  port_range            = "80"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  ip_address            = google_compute_global_address.cdn_ip.address
}

resource "google_compute_global_forwarding_rule" "https_forwarding_rule" {
  name       = "${var.cdn_name}-forwarding-rule-https"
  port_range = "443"
  target     = google_compute_target_https_proxy.cdn_https_proxy.self_link
  ip_address = google_compute_global_address.cdn_ip.address
}

resource "google_compute_health_check" "hc" {
  name                = "${var.backend_name}-hc"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2

  http_health_check {
    port         = var.health_check_port
    request_path = var.health_check_path
  }
}