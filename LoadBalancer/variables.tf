variable "project" {
  description = "The GCP project ID where resources will be deployed."
  type        = string
}

variable "region" {
  description = "The GCP region where the load balancer will be deployed."
  type        = string
  default     = "us-central1"
}

variable "load_balancer_variables" {
  description = "Map of configurations for the Google Cloud HTTPS Load Balancer."
  type = map(object({
    name                 = string # (Required) The name of the Load Balancer.
    backend_service_name = string # (Required) The name of the backend service.
    backend_service_port = number # (Required) The port of the backend service.
    health_check_name    = string # (Required) The name of the health check.
    frontend_ip          = string # (Required) The IP address for the frontend.
    target_pool_name     = string # (Required) The name of the target pool.
    url_map_name         = string # (Required) The name of the URL map.
    compute_instance_group = object({
      name = string # (Required) The name of the instance group.
      zone = string # (Required) The zone where the instance group is located.
    })
    port_name                        = string # (Optional) The port name for the backend service.
    protocol                         = string # (Optional) The protocol for the backend service.
    timeout_sec                      = number # (Optional) The timeout in seconds for the backend service.
    ssl_certificate_name             = string # (Required) The name of the SSL certificate.
    ssl_certificate_path             = string # (Required) Path to the SSL certificate file.
    ssl_certificate_private_key_path = string # (Required) Path to the SSL certificate private key file.
    check_interval_sec               = number # (Optional) The interval between health checks.
    unhealthy_threshold              = number # (Optional) The number of failed health checks before marking as unhealthy.
    healthy_threshold                = number # (Optional) The number of successful health checks before marking as healthy.
  }))
}