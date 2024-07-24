# The Google Cloud Project ID where resources will be deployed.
project = "RNS-ID"

# The GCP region where the Cloud Run services should be deployed.
region = "us-central1"


google_cloudrun_variables = { # Configuration for Google Cloud Run services.
  "google_cloudrun_variables_1" = {
    name     = "RNS-ID-CloudRun" # (Required) The name of the Cloud Run service. Changing this forces a new Cloud Run service to be created.
    location = "us-central1"     # (Required) The GCP region where the Cloud Run service should be deployed. Changing this forces a new Cloud Run service to be created.
    template = {
      name = "gcr.io/my-project/my-image:latest" # (Required) The container image to deploy.
    }
    traffic = {
      percent         = 100  # (Required) The percentage of traffic to direct to the specified revision.
      latest_revision = true # (Required) Whether to direct traffic to the latest revision.
    }
  }
}
