resource "kubernetes_deployment" "cliptozip_videoprc" {
  metadata {
    name = "cliptozip-videoprc"
    labels = {
      app = "cliptozip-videoprc"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "cliptozip-videoprc"
      }
    }

    template {
      metadata {
        labels = {
          app = "cliptozip-videoprc"
        }
      }

      spec {
        container {
          name              = "cliptozip-videoprc"
          image             = var.videoprc_image_url
          image_pull_policy = "Always"

          port {
            container_port = 3000
            protocol       = "TCP"
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
            name = "S3_BUCKET_NAME"
            value_from {
              secret_key_ref {
                name = "cliptozip-secret"
                key = "S3_BUCKET_NAME"
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
            name = "CLIPTOZIP_NOTIFICATIONS_URL"
            value_from {
              secret_key_ref {
                name = "cliptozip-secret"
                key = "CLIPTOZIP_NOTIFICATIONS_URL"
              }
            }
          }

          env {
            name = "DB_HOST"
            value_from {
              secret_key_ref{
                name = "cliptozip-secret"
                key = "DB_HOST"
              }
            }
          }

          env {
            name = "DB_NAME"
            value_from {
              secret_key_ref{
                name = "cliptozip-secret"
                key = "DB_NAME"
              }
            }
          }

          env {
            name = "DB_PORT"
            value = "5432"
          }

          env {
            name = "DB_USER"
            value_from {
              secret_key_ref{
                name = "cliptozip-secret"
                key = "POSTGRES_USER"
              }
            }
          }

          env {
            name = "DB_PASSWORD"
            value_from {
              secret_key_ref{
                name = "cliptozip-secret"
                key = "POSTGRES_PASSWORD"
              }
            }
          }

          env {
            name = "APP_NAME"
            value = "py-cliptozip-video-processor"
          }
          env {
            name = "LOG_LEVEL"
            value = "INFO"
          }
          env {
            name = "MAX_WORKERS"
            value = "3"
          }

          liveness_probe {
            http_get {
              path = "/py-cliptozip-video-processor/health"
              port = 3000
            }
            initial_delay_seconds = 120
            period_seconds        = 30
            timeout_seconds       = 10
            failure_threshold     = 3
          }

          readiness_probe {
            http_get {
              path = "/py-cliptozip-video-processor/health"
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
