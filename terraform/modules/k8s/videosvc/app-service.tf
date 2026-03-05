resource "kubernetes_service" "cliptozip_videosvc_lb" {
    metadata {
        name = "cliptozip-videosvc"
        labels = {
            app = "cliptozip-videosvc"
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
            app = "cliptozip-videosvc"
        }
    }
}

output "videosvc_load_balancer_hostname" {
    value       = kubernetes_service.cliptozip_videosvc_lb.status[0].load_balancer[0].ingress[0].hostname
    description = "Hostname do Load Balancer do videosvc"
}