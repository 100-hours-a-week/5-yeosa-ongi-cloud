output "nat_name" {
  description = "NAT Gateway 이름"
  value       = google_compute_router_nat.nat.name
}
