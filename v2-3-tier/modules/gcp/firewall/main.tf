resource "google_compute_firewall" "allow_tcp_udp_ports" {
  name    = var.firewall_name
  network = var.vpc

  dynamic "allow" {
    for_each = var.allow_tcp_ports != null ? [1] : []
    content {
      protocol = "tcp"
      ports    = var.allow_tcp_ports
    }
  }

  dynamic "allow" {
    for_each = var.allow_udp_ports != null ? [1] : []
    content {
      protocol = "udp"
      ports    = var.allow_udp_ports
    }
  }

  source_tags   = var.source_tags != null ? var.source_tags : null
  source_ranges = var.source_ranges != null ? var.source_ranges : null
  target_tags   = var.target_tags
}
