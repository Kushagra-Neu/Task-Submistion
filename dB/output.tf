output "db_instance_name" {
  description = "The name of the SQL database instance."
  value       = google_sql_database_instance.my_instance.name
}

output "database_name" {
  description = "The name of the created SQL database."
  value       = google_sql_database.my_database.name
}
