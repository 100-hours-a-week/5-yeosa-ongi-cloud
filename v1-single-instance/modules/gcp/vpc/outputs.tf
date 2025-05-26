output "vpc_name" {
  description = "생성된 VPC 네트워크 이름"
  value       = google_compute_network.vpc_network.name
}

output "subnet_self_link" {
  description = "서브넷 self link"
  value       = google_compute_subnetwork.public_subnet.self_link
}

output "network_self_link" {
  description = "네트워크 self link"
  value       = google_compute_network.vpc_network.self_link
}
