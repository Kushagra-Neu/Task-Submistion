output "backend_service_id" {
  description = "The ID of the Backend Service."
  value       = { for k, v in google_compute_backend_service.backend_service : k => v.id }
}

# Output the URL of the Frontend Forwarding Rule
output "frontend_forwarding_rule_url" {
  description = "The URL of the Frontend Forwarding Rule."
  value       = { for k, v in google_compute_forwarding_rule.https_frontend : k => v.self_link }
}

# Output the URL Map ID
output "url_map_id" {
  description = "The ID of the URL Map."
  value       = { for k, v in google_compute_url_map.url_map : k => v.id }
}

# Output the Target HTTPS Proxy ID
output "target_https_proxy_id" {
  description = "The ID of the Target HTTPS Proxy."
  value       = { for k, v in google_compute_target_https_proxy.target_https_proxy : k => v.id }
}

# Output the SSL Certificate ID
output "ssl_certificate_id" {
  description = "The ID of the SSL Certificate."
  value       = { for k, v in google_compute_ssl_certificate.ssl_certificate : k => v.id }
}

# Output the Target Pool ID
output "target_pool_id" {
  description = "The ID of the Target Pool."
  value       = { for k, v in google_compute_target_pool.target_pool : k => v.id }
}