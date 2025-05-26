resource "google_compute_disk_resource_policy_attachment" "web_disk_attachment" {
  name = google_compute_resource_policy.web_snapshot_policy.name
  disk = var.web_boot_disk_name
  zone = var.zone
}

resource "google_compute_disk_resource_policy_attachment" "ai_disk_attachment" {
  name = google_compute_resource_policy.ai_snapshot_policy.name
  disk = var.ai_boot_disk_name
  zone = var.zone
}