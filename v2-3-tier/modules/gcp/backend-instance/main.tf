resource "google_compute_instance" "backend" {
  name         = var.instance_name
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = var.boot_image
      size  = var.boot_disk_size
    }
  }

  network_interface {
    subnetwork = var.subnet_self_link
  }

  tags = var.tags
}
