output "backend_service_instance_group" {
  value = google_compute_region_instance_group_manager.mig.instance_group
}

output "backend_service_named_port" {
  value = var.service_port
}
