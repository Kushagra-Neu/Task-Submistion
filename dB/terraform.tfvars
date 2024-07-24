project = "<YOUR_PROJECT_ID>"
region  = "us-central1"

db_instance = {
  name                            = "my-sql-instance"
  tier                            = "db-f1-micro"
  database_version                = "POSTGRES_13"
  root_password                   = "your-secure-password"
  db_name                         = "mydatabase"
  region                          = "us-central1"
  availability_type               = "ZONAL"
  maintenance_window_day          = 0
  maintenance_window_hour         = 0
  maintenance_window_update_track = "stable"
  credentials_file                = "path/to/your/credentials-file.json"
}

