resource "kubernetes_service" "cliptozip_auth_lb" {
    metadata {
        name = "cliptozip-auth"
        labels = {
            app = "cliptozip-auth"
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
            app = "cliptozip-auth"
        }
    }
}

output "auth_load_balancer_hostname" {
    value       = kubernetes_service.cliptozip_auth_lb.status[0].load_balancer[0].ingress[0].hostname
    description = "Hostname do Load Balancer do Auth"
}