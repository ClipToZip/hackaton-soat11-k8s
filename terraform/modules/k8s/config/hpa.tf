resource "kubernetes_horizontal_pod_autoscaler_v2" "cliptozip_hpa" {
  metadata {
    name = "cliptozip-hpa"
  }

  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = "cliptozip"
    }

    min_replicas = 1
    max_replicas = 5

    metric {
      type = "Resource"

      resource {
        name = "cpu"

        target {
          type                 = "Utilization"
          average_utilization  = 50
        }
      }
    }
  }
}
