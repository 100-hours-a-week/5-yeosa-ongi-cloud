resource "google_compute_health_check" "hc" {
  name                = "${var.name}-hc"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2

  http_health_check {
    port         = var.health_check_port
    request_path = var.health_check_path
  }
}

resource "google_compute_global_address" "alb_ip" {
  name = "${var.name}-alb-ip"
}

resource "google_compute_backend_service" "backend_service" {
  name          = "${var.name}-backend-service"
  protocol      = "HTTP"
  port_name     = "http"
  timeout_sec   = 30
  health_checks = [google_compute_health_check.hc.self_link]
  backend {
    group = var.instance_group
  }
}

resource "google_compute_url_map" "url_map" {
  name            = "${var.name}-url-map"
  default_service = var.default_path_target

  path_matcher {
    name            = "routing"
    default_service = var.default_path_target

    path_rule {
      paths   = [var.api_path_prefix]
      service = google_compute_backend_service.backend_service.self_link
    }

    path_rule {
      paths   = [var.static_path_prefix]
      service = var.backend_bucket
    }
  }
  host_rule {
    hosts        = ["*"]
    path_matcher = "routing"
  }
}

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "${var.name}-http-proxy"
  url_map = google_compute_url_map.url_map.self_link
}

resource "google_compute_global_forwarding_rule" "forwarding_rule" {
  name       = "${var.name}-fwd-rule"
  target     = google_compute_target_http_proxy.http_proxy.self_link
  port_range = "80"
  ip_address = google_compute_global_address.alb_ip.address
}
