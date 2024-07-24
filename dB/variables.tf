variable "project" {
  description = "The Google Cloud Project ID where resources will be deployed."
  type        = string
}

variable "region" {
  description = "The GCP region where the Cloud SQL instance will be deployed."
  type        = string
}

variable "db_instance" {
  description = "Configuration for the Cloud SQL instance."
  type = object({
    name                            = string # (Required) The name of the Cloud SQL instance.
    tier                            = string # (Required) The tier of the Cloud SQL instance (e.g., db-f1-micro).
    database_version                = string # (Required) The database version (e.g., MYSQL_5_7).
    root_password                   = string # (Required) The password for the root user.
    db_name                         = string # (Required) The name of the database to be created.
    region                          = string # (Optional) The region where the instance will be created.
    availability_type               = string # (Optional) The availability type for the instance (e.g., ZONAL or REGIONAL).
    maintenance_window_day          = number # (Optional) The day of the week (0-6) for the maintenance window.
    maintenance_window_hour         = number # (Optional) The hour of the day (0-23) for the maintenance window.
    maintenance_window_update_track = string # (Optional) The update track for the maintenance window (e.g., 'stable', 'canary').
    credentials_file                = string # (Required) The path to the Google Cloud credentials file.
  })
}
