resource "google_compute_firewall" "allow_tcp_ports" {
  name    = var.firewall_name
  network = var.vpc

  dynamic "allow" {
    for_each = var.allowed_ports
    content {
      protocol = "tcp"
      ports    = [allow.value]
    }
  }

  source_ranges = var.source_ranges
  target_tags   = var.target_tags
}
