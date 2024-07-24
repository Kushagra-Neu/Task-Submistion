# Define the data block for Google Compute Instance Group
data "google_compute_instance_group" "instance_group" {
  for_each = var.load_balancer_variables
  name     = each.value.compute_instance_group.name
  zone     = each.value.compute_instance_group.zone
}

resource "google_compute_http_health_check" "health_check" {
  for_each            = var.load_balancer_variables
  name                = each.value.health_check_name
  request_path        = "/"
  check_interval_sec  = each.value.check_interval_sec
  timeout_sec         = each.value.timeout_sec
  healthy_threshold   = each.value.healthy_threshold
  unhealthy_threshold = each.value.unhealthy_threshold
}

# SSL Certificate Configuration
resource "google_compute_ssl_certificate" "ssl_certificate" {
  for_each    = var.load_balancer_variables
  name        = each.value.ssl_certificate_name
  private_key = file(each.value.ssl_certificate_private_key_path)
  certificate = file(each.value.ssl_certificate_path)
}

# HTTPS Target Proxy Configuration
resource "google_compute_target_https_proxy" "target_https_proxy" {
  for_each         = var.load_balancer_variables
  name             = "${each.value.name}-https-proxy"
  url_map          = google_compute_url_map.url_map[each.key].id
  ssl_certificates = [google_compute_ssl_certificate.ssl_certificate[each.key].id]
}

# Backend Service Configuration
resource "google_compute_backend_service" "backend_service" {
  for_each      = var.load_balancer_variables
  name          = each.value.backend_service_name
  port_name     = each.value.port_name
  protocol      = each.value.protocol
  timeout_sec   = each.value.timeout_sec
  health_checks = [google_compute_http_health_check.health_check[each.key].id]
  backend {
    group = data.google_compute_instance_group.instance_group[each.key].id
  }
}

# HTTPS Forwarding Rule Configuration
resource "google_compute_forwarding_rule" "https_frontend" {
  for_each    = var.load_balancer_variables
  name        = "${each.value.name}-RNS-https-frontend"
  ip_address  = each.value.frontend_ip
  ip_protocol = each.value.ip_protocol
  port_range  = each.value.port_range
  target      = google_compute_target_https_proxy.target_https_proxy[each.key].id
}

# URL Map Configuration
resource "google_compute_url_map" "url_map" {
  for_each        = var.load_balancer_variables
  name            = each.value.url_map_name
  default_service = google_compute_backend_service.backend_service[each.key].id
}

# Target Pool Configuration (if needed, usually for TCP/UDP Load Balancers)
resource "google_compute_target_pool" "target_pool" {
  for_each = var.load_balancer_variables
  name     = each.value.target_pool_name
}