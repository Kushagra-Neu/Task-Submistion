# The Google Cloud Project ID where resources will be deployed.
project = "<YOUR_PROJECT_ID>"

# The GCP region where the load balancer will be deployed.
region = "us-central1"

# Configuration for Google Cloud Load Balancer.
load_balancer_variables = {
  "load_balancer_1" = {
    name                 = "RNS-https-load-balancer"
    backend_service_name = "RNS-backend-service"
    backend_service_port = 80
    health_check_name    = "RNS-health-check"
    frontend_ip          = "10.0.0.1"
    target_pool_name     = "RNS-target-pool"
    url_map_name         = "RNS-url-map"
    compute_instance_group = {
      name = "RNS-instance-group"
      zone = "us-central1-a"
    }
    port_name                        = "http"
    protocol                         = "HTTP"
    timeout_sec                      = 10
    ssl_certificate_name             = "RNS-ssl-certificate"
    ssl_certificate_path             = "/path/to/your/certificate.crt"
    ssl_certificate_private_key_path = "/path/to/your/private-key.key"
    check_interval_sec               = 10
    unhealthy_threshold              = 2
    healthy_threshold                = 2
  }
}