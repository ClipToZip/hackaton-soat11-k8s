resource "kubernetes_service" "cliptozip_notification_lb" {
    metadata {
        name = "cliptozip-notification"
        labels = {
            app = "cliptozip-notification"
        }
    }

    spec {
        type = "LoadBalancer"

        port {
            name       = "80"
            port        = 80
            target_port = 3000
        }

        selector = {
            app = "cliptozip-notification"
        }
    }
}

output "notification_load_balancer_hostname" {
    value       = kubernetes_service.cliptozip_notification_lb.status[0].load_balancer[0].ingress[0].hostname
    description = "Hostname do Load Balancer do notification"
}