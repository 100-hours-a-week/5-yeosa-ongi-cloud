resource "google_sql_database_instance" "replica" {
  name                 = var.replica_name
  database_version     = var.database_version
  master_instance_name = google_sql_database_instance.master.name

  replica_configuration {
    failover_target = false
  }

  settings {
    tier              = var.db_tier
    availability_type = "ZONAL"

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_self_link
    }
  }

  deletion_protection = false

  # lifecycle {
  #   prevent_destroy = true
  # }
}
