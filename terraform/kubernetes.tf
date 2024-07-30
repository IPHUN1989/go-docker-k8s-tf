resource "kubernetes_manifest" "namespace" {
  manifest = yamldecode(file("../kubernetes/namespace.yaml"))
}

resource "kubernetes_manifest" "deployment" {
  manifest = yamldecode(file("../kubernetes/deployment.yaml"))
}

resource "kubernetes_manifest" "service" {
  manifest = yamldecode(file("../kubernetes/service.yaml"))
}