resource "kubernetes_deployment" "cliptozip_videosvc" {
  metadata {
    name = "cliptozip-videosvc"
    labels = {
      app = "cliptozip-videosvc"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "cliptozip-videosvc"
      }
    }

    template {
      metadata {
        labels = {
          app = "cliptozip-videosvc"
        }
      }

      spec {
        container {
          name              = "cliptozip-videosvc"
          image             = var.videosvc_image_url
          image_pull_policy = "Always"

          port {
            container_port = 3000
            protocol       = "TCP"
          }

          env {
            name = "SPRING_DATASOURCE_URL"
            value_from {
              config_map_key_ref {
                name = "cliptozip-configmap"
                key  = "SPRING_DATASOURCE_URL"
              }
            }
          }

          env {
            name = "SPRING_DATASOURCE_USERNAME"
            value_from {
              secret_key_ref {
                name = "cliptozip-secret"
                key  = "SPRING_DATASOURCE_USERNAME"
              }
            }
          }

          env {
            name = "SPRING_DATASOURCE_PASSWORD"
            value_from {
              secret_key_ref {
                name = "cliptozip-secret"
                key  = "SPRING_DATASOURCE_PASSWORD"
              }
            }
          }

          env {
            name = "CLIPTOZIP_EVENTS_URL"
            value_from {
              secret_key_ref {
                name = "cliptozip-secret"
                key = "CLIPTOZIP_EVENTS_URL"
              }
            }
          }

          env {
            name = "S3_BUCKET_NAME"
            value_from {
              secret_key_ref {
                name = "cliptozip-secret"
                key = "S3_BUCKET_NAME"
              }
            }
          }

          env {
            name = "AWS_REGION"
            value_from {
              secret_key_ref{
                name = "cliptozip-secret"
                key = "AWS_REGION"
              }
            }
          }
          
          env {
            name = "AWS_ACCESS_KEY_ID"
            value_from {
              secret_key_ref{
                name = "cliptozip-secret"
                key  = "AWS_ACCESS_KEY_ID"
              }
            }
          }

          env {
            name = "AWS_SECRET_ACCESS_KEY"
            value_from {
              secret_key_ref{
                name = "cliptozip-secret"
                key = "AWS_SECRET_ACCESS_KEY"
              }
            }
          }

          env {
            name = "AUTH_API_URL"
            value = "http://cliptozip-auth:80/auth/validate-token"
          }

          liveness_probe {
            http_get {
              path = "/actuator/health"
              port = 3000
            }
            initial_delay_seconds = 120
            period_seconds        = 30
            timeout_seconds       = 10
            failure_threshold     = 3
          }

          readiness_probe {
            http_get {
              path = "/actuator/health"
              port = 3000
            }
            initial_delay_seconds = 60
            period_seconds        = 10
            timeout_seconds       = 5
            failure_threshold     = 3
          }

          resources {
            limits = {
              cpu    = "1000m"
              memory = "1Gi"
            }

            requests = {
              cpu    = "500m"
              memory = "512Mi"
            }
          }
        }

        restart_policy = "Always"
      }
    }

  }
}
