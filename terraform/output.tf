output "cliptozip_auth_load_balancer_hostname" {
  value       = module.k8s_auth.auth_load_balancer_hostname
  description = "Hostname do Load Balancer do Auth"
}

output "cliptozip_videosvc_load_balancer_hostname" {
  value       = module.k8s_videosvc.videosvc_load_balancer_hostname
  description = "Hostname do Load Balancer do Video Service"
}

output "cliptozip_videoprc_load_balancer_hostname" {
  value       = module.k8s_videoprc.videoprc_load_balancer_hostname
  description = "Hostname do Load Balancer do Video Processing"
}

output "cliptozip_notification_load_balancer_hostname" {
  value       = module.k8s_notification.notification_load_balancer_hostname
  description = "Hostname do Load Balancer do Notification"
}