output "cliptozip_auth_load_balancer_hostname" {
  value       = module.k8s_auth.auth_load_balancer_hostname
  description = "Hostname do Load Balancer do Auth"
}