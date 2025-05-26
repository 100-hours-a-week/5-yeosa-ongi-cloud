resource "google_compute_firewall" "allow_tcp_ports" {
  name    = var.firewall_name
  network = var.vpc

  allow {
    protocol = "tcp"
    ports = var.allowed_ports
  }

  source_tags   = var.source_tags != null ? var.source_tags : null
  source_ranges = var.source_ranges != null ? var.source_ranges : null
  target_tags   = var.target_tags
}
