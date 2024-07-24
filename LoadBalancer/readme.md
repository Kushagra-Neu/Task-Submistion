# Terraform Google Cloud HTTPS Load Balancer Configuration

This repository contains Terraform configurations for deploying and managing an HTTPS Load Balancer in Google Cloud Platform (GCP).

## Attributes

- **load_balancer_variables** (map of objects) - (Required) Configuration map for the HTTPS Load Balancer.
  - `name` (string) - (Required) The name of the Load Balancer.
  - `backend_service_name` (string) - (Required) The name of the backend service.
  - `backend_service_port` (number) - (Required) The port of the backend service.
  - `health_check_name` (string) - (Required) The name of the health check.
  - `frontend_ip` (string) - (Required) The IP address for the frontend.
  - `target_pool_name` (string) - (Required) The name of the target pool.
  - `url_map_name` (string) - (Required) The name of the URL map.
  - `compute_instance_group` (object) - (Required) Configuration for the instance group.
    - `name` (string) - (Required) The name of the instance group.
    - `zone` (string) - (Required) The zone where the instance group is located.
  - `port_name` (string) - (Optional) The port name for the backend service. Default is `"http"`.
  - `protocol` (string) - (Optional) The protocol for the backend service. Default is `"HTTP"`.
  - `timeout_sec` (number) - (Optional) The timeout in seconds for the backend service. Default is `10`.
  - `ssl_certificate_name` (string) - (Required) The name of the SSL certificate.
  - `ssl_certificate_path` (string) - (Required) Path to the SSL certificate file.
  - `ssl_certificate_private_key_path` (string) - (Required) Path to the SSL certificate private key file.
  - `check_interval_sec` (number) - (Optional) The interval in seconds between health checks. Default is `10`.
  - `unhealthy_threshold` (number) - (Optional) The number of failed health checks before marking an instance as unhealthy. Default is `2`.
  - `healthy_threshold` (number) - (Optional) The number of successful health checks before marking an instance as healthy. Default is `2`.
