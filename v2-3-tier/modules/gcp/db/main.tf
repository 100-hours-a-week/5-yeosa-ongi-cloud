resource "google_sql_database_instance" "master" {
  name             = var.master_name
  database_version = var.database_version

  settings {
    tier              = var.db_tier
    availability_type = "ZONAL"
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_self_link
    }
    backup_configuration {
      enabled            = true
      binary_log_enabled = true
    }
    database_flags {
      name  = "log_bin_trust_function_creators"
      value = "on"
    }
  }

  deletion_protection = false
  # deletion_protection = true

  # lifecycle {
  #   prevent_destroy = true
  # }

  depends_on = [
    google_service_networking_connection.sql_peering,
    google_compute_global_address.sql_range
  ]
}
