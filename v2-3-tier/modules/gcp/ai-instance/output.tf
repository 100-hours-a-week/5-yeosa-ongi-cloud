output "instance_name" {
  value = google_compute_instance.ai.name
}

output "internal_ip" {
  value = google_compute_instance.ai.network_interface[0].network_ip
}
