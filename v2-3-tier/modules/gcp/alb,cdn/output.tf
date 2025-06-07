output "cdn_ip_address" {
  description = "IP address for the CDN"
  value       = google_compute_global_address.cdn_ip.address
}

output "backend_bucket" {
  description = "The backend bucket for the CDN"
  value       = google_compute_backend_bucket.cdn_backend.self_link
}