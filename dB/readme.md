# Terraform Google Cloud SQL Configuration

This repository contains Terraform configurations for deploying and managing a Google Cloud SQL instance.

## Attributes

- **db_instance** (object) - (Required) Configuration for the Cloud SQL instance.
  - `name` (string) - (Required) The name of the Cloud SQL instance.
  - `tier` (string) - (Required) The tier of the Cloud SQL instance (e.g., `db-f1-micro`).
  - `database_version` (string) - (Required) The database version (e.g., `MYSQL_5_7`).
  - `root_password` (string) - (Required) The password for the root user.
  - `db_name` (string) - (Required) The name of the database to be created.
  - `region` (string) - (Optional) The region where the instance will be created. Default is `us-central1`.
  - `availability_type` (string) - (Optional) The availability type for the instance (e.g., `ZONAL` or `REGIONAL`). Default is `ZONAL`.
  - `maintenance_window_day` (number) - (Optional) The day of the week (0-6) for the maintenance window. Default is `0`.
  - `maintenance_window_hour` (number) - (Optional) The hour of the day (0-23) for the maintenance window. Default is `0`.
  - `maintenance_window_update_track` (string) - (Optional) The update track for the maintenance window (e.g., `stable`, `canary`). Default is `stable`.
  - `credentials_file` (string) - (Required) The path to the Google Cloud credentials file.
