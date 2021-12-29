data "digitalocean_kubernetes_cluster" "cluster" {
  name = "terraform-cluster"
}

provider "kubernetes" {
  host  = data.digitalocean_kubernetes_cluster.cluster.endpoint
  token = data.digitalocean_kubernetes_cluster.cluster.kube_config[0].token
  cluster_ca_certificate = base64decode(
    data.digitalocean_kubernetes_cluster.cluster.kube_config[0].cluster_ca_certificate
  )
}

resource "kubernetes_namespace" "demo" {
  metadata {
    annotations = {
      name = "demo-annotation"
    }


    labels = {
      demolabel = "demo-label"
    }

    name = "demo"

  }
}
