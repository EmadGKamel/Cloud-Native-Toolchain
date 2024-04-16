# name: metallb.tf
resource "helm_release" "metallb" {
  name             = "metallb"
  atomic           = true
  create_namespace = true
  namespace        = "metallb-system"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "metallb"
  timeout          = 300
  depends_on = []
}


resource "kubernetes_manifest" "advertisement_config" {
  manifest = {
    "apiVersion" = "metallb.io/v1beta1"
    "kind"       = "L2Advertisement"
    "metadata" = {
      "name"      = "advertisement-config"
      "namespace" = "metallb-system"
    }
  }
}

resource "kubernetes_manifest" "ipaddress_pool" {
  manifest = {
    "apiVersion" = "metallb.io/v1beta1"
    "kind"       = "IPAddressPool"
    "metadata" = {
      "name"      = "ipadress-pool-config"
      "namespace" = "metallb-system"
    }
    "spec" = {
      "addresses" = ["172.18.255.200-172.18.255.250"]
    }
  }
}