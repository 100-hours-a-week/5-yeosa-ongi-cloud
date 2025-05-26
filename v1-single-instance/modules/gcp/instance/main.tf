resource "google_compute_address" "static_ip" {
  count  = var.use_static_ip ? 1 : 0
  name   = "${var.instance_name}-static-ip"
}
resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.boot_image
      size  = var.boot_disk_size
      type  = var.boot_disk_type
    }
  }

  network_interface {
    network    = var.vpc
    subnetwork = var.subnet
    dynamic "access_config" {
      for_each = var.assign_external_ip ? [1] : []
      content {
        nat_ip = var.use_static_ip ? google_compute_address.static_ip[0].address : null # 외부 IP 할당
      }
    }
  }

  tags = var.tags
}
