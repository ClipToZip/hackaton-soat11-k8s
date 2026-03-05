resource "kubernetes_deployment" "cliptozip_notification" {
  metadata {
    name = "cliptozip-notification"
    labels = {
      app = "cliptozip-notification"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "cliptozip-notification"
      }
    }

    template {
      metadata {
        labels = {
          app = "cliptozip-notification"
        }
      }

      spec {
        container {
          name              = "cliptozip-notification"
          image             = var.notification_image_url
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
            name = "SPRING_MAIL_HOST"
            value = "smtp.gmail.com"
          }

          env {
            name = "SPRING_MAIL_PORT"
            value = "587"
          }

          env {
            name = "SPRING_MAIL_USERNAME"
            value_from {
              secret_key_ref{
                name = "cliptozip-secret"
                key = "SPRING_MAIL_USERNAME"
              }
            }
          }

          env {
            name = "SPRING_MAIL_PASSWORD"
            value_from {
              secret_key_ref{
                name = "cliptozip-secret"
                key = "SPRING_MAIL_PASSWORD"
              }
            }
          }

          env {
            name = "SPRING_MAIL_PROPERTIES_MAIL_SMTP_AUTH"
            value = "true"
          }
          env {
            name = "SPRING_MAIL_PROPERTIES_MAIL_SMTP_STARTTLS_ENABLE"
            value = "true"
          }

          env {
            name = "APP_SQS_QUEUE_NAME"
            value_from {
              secret_key_ref{
                name = "cliptozip-secret"
                key = "CLIPTOZIP_NOTIFICATIONS_NAME"
              }
            }
          }

          env {
            name = "APP_EMAIL_FROM"
            value_from {
              secret_key_ref{
                name = "cliptozip-secret"
                key = "SPRING_MAIL_USERNAME"
              }
            }
          }

          env {
            name = "APP_DEDUP_ENABLES"
            value = "true"
          }
          env {
            name = "APP_DEDUP_TTL_SECONDS"
            value = "3600"
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
