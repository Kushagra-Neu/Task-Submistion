variable "project" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "google_cloudrun_variables" {
  description = "Map of configurations for Google Cloud Run services"
  type = map(object({
    name     = string
    location = string
    template = object({
      name = string
    })
    traffic = object({
      percent         = number
      latest_revision = bool
    })
  }))
}
