output "master_connection_name" {
  value = google_sql_database_instance.master.connection_name
}

output "replica_connection_name" {
  value = google_sql_database_instance.replica.connection_name
}

output "sql_range_name" {
  value = google_compute_global_address.sql_range.name
}
