output "vpc_name" {
  value = google_compute_network.vpc.name
}

output "vpc_self_link" {
  value = google_compute_network.vpc.self_link
}

output "subnet_openvpn_self_link" {
  value = google_compute_subnetwork.subnet_openvpn.self_link
}

output "subnet_server_self_link" {
  value = google_compute_subnetwork.subnet_server.self_link
}