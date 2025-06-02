resource "google_compute_address" "openvpn_ip" {
  name         = "${var.instance_name}-ip"
  address_type = "EXTERNAL"
  
}
resource "google_compute_instance" "openvpn" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.boot_image
      size  = 20
    }
  }

  network_interface {
    subnetwork = var.subnet_self_link
    access_config {
      nat_ip = google_compute_address.openvpn_ip.address 
    }
  }

  tags = var.tags

  metadata_startup_script = var.startup_script
}
