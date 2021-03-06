
resource "kubernetes_manifest" "phpmyadmin" {

  manifest = {
    "apiVersion" = "apps/v1"
    "kind"       = "Deployment"
    "metadata" = {
      "labels" = {
        "app" = "myadmin"
      }
      "name"      = "myadmin"
      "namespace" = "demo"
    }
    "spec" = {
      "replicas" = 3
      "selector" = {
        "matchLabels" = {
          "app" = "myadmin"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "myadmin"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name"  = "PMA_ARBITRARY"
                  "value" = "1"
                },
              ]
              "image"           = "phpmyadmin/phpmyadmin:latest"
              "imagePullPolicy" = "Always"
              "name"            = "phpmyadmin"
              "ports" = [
                {
                  "containerPort" = 80
                  "name"          = "http"
                  "protocol"      = "TCP"
                },
              ]
            },
          ]
        }
      }
    }
  }
}


resource "kubernetes_manifest" "phpmyadminLB" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Service"
    "metadata" = {
      "labels" = {
        "app" = "myadmin"
      }
      "name"      = "myadmin"
      "namespace" = "demo"
    }
    "spec" = {
      "ports" = [
        {
          "name"       = "http"
          "port"       = 80
          "protocol"   = "TCP"
          "targetPort" = "http"
        },
      ]
      "selector" = {
        "app" = "myadmin"
      }
      "type" = "LoadBalancer"
    }
  }
}
