output "backend_service_self_link" {
  value = google_compute_backend_service.backend_service.self_link
}

output "alb_ip" {
  value = google_compute_global_address.alb_ip.address
}