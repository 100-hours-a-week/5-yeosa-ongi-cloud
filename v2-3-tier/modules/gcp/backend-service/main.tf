resource "google_compute_instance_template" "template" {
  name_prefix  = "${var.name}-template"
  machine_type = var.machine_type
  tags         = var.tags

  disk {
    boot         = true
    auto_delete  = true
    source_image = var.source_image
  }

  network_interface {
    subnetwork = var.subnetwork
  }

  lifecycle {
    create_before_destroy = true
  }

  metadata_startup_script = file("${path.root}/scripts/install_docker.sh") 
}

resource "google_compute_region_instance_group_manager" "mig" {
  name                      = "${var.name}-mig"
  region                    = var.region
  base_instance_name        = "${var.name}"
  distribution_policy_zones = var.zones

  version {
    instance_template = google_compute_instance_template.template.self_link
  }

  target_size = var.initial_size

  named_port {
    name = "http"
    port = var.service_port
  }
}

# resource "google_compute_region_autoscaler" "autoscaler" {
#   name   = "${var.name}-autoscaler"
#   region = var.region
#   target = google_compute_region_instance_group_manager.mig.self_link

#   autoscaling_policy {
#     max_replicas    = var.max_replicas
#     min_replicas    = var.min_replicas
#     cooldown_period = 60

#     cpu_utilization {
#       target = var.cpu_utilization_target
#     }
#   }
#   depends_on = [
#     google_compute_region_instance_group_manager.mig
#   ]
# }
