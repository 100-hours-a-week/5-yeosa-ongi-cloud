resource "google_compute_router" "router" {
  name    = var.router_name
  network = var.vpc_self_link
}

resource "google_compute_router_nat" "nat" {
  name                               = var.nat_name
  router                             = google_compute_router.router.name
  nat_ip_allocate_option             = var.nat_ip_allocate_option
  source_subnetwork_ip_ranges_to_nat = var.source_subnetwork_ip_ranges_to_nat

  log_config {
    enable = var.log_config_enable
    filter = "ERRORS_ONLY" # 오류 로그만 기록
  }
}
