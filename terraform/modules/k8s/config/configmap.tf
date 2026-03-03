resource "kubernetes_config_map" "cliptozip_configmap" {
    metadata {
        name = "cliptozip-configmap"
    }

    data = {
        POSTGRES_DB = var.db_name
        SPRING_DATASOURCE_URL = "jdbc:postgresql://${var.db_url}:5432/${var.db_name}"
    }
}