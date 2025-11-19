// outputs.tf
// Useful values printed after terraform apply.

output "instance_connection_name" {
  description = "Cloud SQL instance connection name (used by Cloud SQL Proxy)"
  value       = google_sql_database_instance.cloud_sql_instance.connection_name
}

output "public_ip_address" {
  description = "Public IPv4 address of the Cloud SQL instance"
  value       = google_sql_database_instance.cloud_sql_instance.public_ip_address
}

output "demo_database_name" {
  description = "Name of the created demo database"
  value       = google_sql_database.demo_database.name
}

output "demo_user_name" {
  description = "Database username created for the demo"
  value       = google_sql_user.demo_user.name
}
