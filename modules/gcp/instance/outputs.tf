output "external_ip" {
  description = "VM 외부 IP 주소"
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}

output "self_link" {
  description = "VM 리소스 self link"
  value       = google_compute_instance.vm_instance.self_link
}
