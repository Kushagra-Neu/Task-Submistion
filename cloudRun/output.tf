output "cloudrun_output" {
  value = { for k, v in google_cloud_run_service.cloudrun : k => {
    id     = v.id
    status = v.status
  } }
}
