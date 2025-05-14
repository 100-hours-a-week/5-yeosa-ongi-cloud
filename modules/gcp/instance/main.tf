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
  }

  metadata = {
    startup-script   = var.startup_script
    application_yml  = var.application_yml
  }

  tags = var.tags
}
