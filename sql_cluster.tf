resource "kubernetes_manifest" "sql-cluster" {

  manifest = {

    "apiVersion" = "kubedb.com/v1alpha2"
    "kind"       = "MySQL"
    "metadata" = {
      "name"      = "my-group"
      "namespace" = "demo"
    }
    "spec" = {
      "replicas" = 3
      "storage" = {
        "accessModes" = [
          "ReadWriteOnce",
        ]
        "resources" = {
          "requests" = {
            "storage" = "1Gi"
          }
        }
        "storageClassName" = "do-block-storage"
      }
      "storageType"       = "Durable"
      "terminationPolicy" = "WipeOut"
      "topology" = {
        "group" = {
          "name" = "dc002fc3-c412-4d18-b1d4-66c1fbfbbc9b"
        }
        "mode" = "GroupReplication"
      }
      "version" = "8.0.27"
    }
  }
}
