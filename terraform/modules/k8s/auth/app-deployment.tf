resource "kubernetes_deployment" "cliptozip_auth" {
  metadata {
    name = "cliptozip-auth"
    labels = {
      app = "cliptozip-auth"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "cliptozip-auth"
      }
    }

    template {
      metadata {
        labels = {
          app = "cliptozip-auth"
        }
      }

      spec {
        container {
          name              = "cliptozip-auth"
          image             = var.auth_image_url
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
            name = "SPRING_DATA_REDIS_HOST"
            value_from {
              secret_key_ref {
                name = "cliptozip-secret"
                key  = "REDIS_HOST"
              }
            }
          }

          env {
            name = "SPRING_DATA_REDIS_PORT"
            value_from {
              secret_key_ref {
                name = "cliptozip-secret"
                key  = "REDIS_PORT"
              }
            }
          }

          env {
            name = "REDIS_SSL_ENABLED"
            value = "true"
          }

          env {
            name = "REDIS_TIMEOUT"
            value = "10000"
          }

          env {
            name = "REDIS_CONNECT_TIMEOUT"
            value = "10000"
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
