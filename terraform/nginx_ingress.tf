# name: nginx_ingress.tf
resource "helm_release" "nginx_ingress" {
  name             = "nginx-ingress-controller"
  atomic           = true
  create_namespace = true
  namespace        = "ingress-nginx"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "nginx-ingress-controller"
  timeout          = 300
  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
  depends_on = [helm_release.metallb]
}
