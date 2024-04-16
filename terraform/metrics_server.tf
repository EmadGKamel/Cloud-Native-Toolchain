# name: nginx_ingress.tf
resource "helm_release" "metrics_server" {
  name             = "metrics-server"
  atomic           = true
  create_namespace = true
  namespace        = "metrics-server"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "metrics-server"
  timeout          = 300
  values = [ "extraArgs:\n  - --kubelet-insecure-tls" ]

  depends_on = []
}
