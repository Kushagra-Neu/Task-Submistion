resource "google_sql_database_instance" "my_instance" {
  name             = var.db_instance.name
  database_version = var.db_instance.database_version
  region           = var.db_instance.region
  settings {
    tier              = var.db_instance.tier
    availability_type = var.db_instance.availability_type
    backup_configuration {
      enabled = true
    }
    maintenance_window {
      day          = var.db_instance.maintenance_window_day
      hour         = var.db_instance.maintenance_window_hour
      update_track = var.db_instance.maintenance_window_update_track
    }
  }
}

resource "google_sql_database" "my_database" {
  name     = var.db_instance.db_name
  instance = google_sql_database_instance.my_instance.name
}

resource "google_sql_user" "root" {
  name     = "root"
  instance = google_sql_database_instance.my_instance.name
  password = var.db_instance.root_password

  depends_on = [
    google_sql_database_instance.my_instance
  ]
}