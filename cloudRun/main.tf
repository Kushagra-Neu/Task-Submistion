resource "google_cloud_run_service" "RNS_cloudrun" {
  for_each = var.google_cloudrun_variables
  name     = each.value.name
  location = each.value.location
  template {
    spec {
      containers {
        image = each.value.template.name
      }
    }
  }
  traffic {
    percent         = each.value.traffic.percent
    latest_revision = each.value.traffic.latest_revision
  }
}