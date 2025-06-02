output "instance_name" {
  value = google_compute_instance.backend.name
}

output "internal_ip" {
  value = google_compute_instance.backend.network_interface[0].network_ip
}
