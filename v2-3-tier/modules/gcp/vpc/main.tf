resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "subnet_openvpn" {
  name                     = var.openvpn_subnet_name
  ip_cidr_range            = var.openvpn_ip_cidr_range
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "subnet_server" {
  name                     = var.server_subnet_name
  ip_cidr_range            = var.server_ip_cidr_range
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "subnet_db" {
  name                     = var.db_subnet_name
  ip_cidr_range            = var.db_ip_cidr_range
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true
}
