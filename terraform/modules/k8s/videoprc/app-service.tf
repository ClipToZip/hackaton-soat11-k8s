resource "kubernetes_service" "cliptozip_videoprc_lb" {
    metadata {
        name = "cliptozip-videoprc"
        labels = {
            app = "cliptozip-videoprc"
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
            app = "cliptozip-videoprc"
        }
    }
}

output "videoprc_load_balancer_hostname" {
    value       = kubernetes_service.cliptozip_videoprc_lb.status[0].load_balancer[0].ingress[0].hostname
    description = "Hostname do Load Balancer do videoprc"
}