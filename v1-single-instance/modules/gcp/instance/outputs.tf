output "boot_disk_name" {
  description = "The name of the boot disk"
  value      = google_compute_instance.vm_instance.name
}