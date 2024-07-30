resource "kubernetes_manifest" "namespace" {
  manifest = yamldecode(file("../kubernetes/namespace.yaml"))
}

resource "kubernetes_manifest" "deployment" {
  manifest = yamldecode(file("../kubernetes/deployment.yaml"))
  depends_on = [kubernetes_manifest.namespace]
}

resource "kubernetes_manifest" "service" {
  manifest = yamldecode(file("../kubernetes/service.yaml"))
  depends_on = [kubernetes_manifest.namespace, kubernetes_manifest.deployment]
}