
resource "kubernetes_manifest" "sql_crd" {
  manifest = {
    "apiVersion" = "kubedb.com/v1alpha2"
    "kind"       = "MySQL"
    "metadata" = {
      "name"      = "mysql-quickstart"
      "namespace" = "demo"
    }
    "spec" = {
      "storage" = {
        "accessModes" = [
          "ReadWriteOnce",
        ]
        "resources" = {
          "requests" = {
            "storage" = "8Gi"
          }
        }
        "storageClassName" = "do-block-storage"
      }
      "storageType"       = "Durable"
      "terminationPolicy" = "DoNotTerminate"
      "version"           = "8.0.27"
    }
  }
}
