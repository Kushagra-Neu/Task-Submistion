# Terraform Google Cloud Run Configuration

This repository contains Terraform configurations for deploying and managing Google Cloud Run services. 

## Attributes

- **google_cloudrun_variables** (map of objects) - (Required) Configuration map for Cloud Run services.
  - `name` (string) - (Required) The name of the Cloud Run service. Changing this forces a new Cloud Run service to be created.
  - `location` (string) - (Required) The GCP region where the Cloud Run service should be deployed. Changing this forces a new Cloud Run service to be created.
  - `template` (object) - (Required) The container configuration for the Cloud Run service.
    - `name` (string) - (Required) The container image to deploy.
  - `traffic` (object) - (Required) Traffic configuration for the Cloud Run service.
    - `percent` (number) - (Required) The percentage of traffic to direct to the specified revision.
    - `latest_revision` (bool) - (Required) Whether to direct traffic to the latest revision.
