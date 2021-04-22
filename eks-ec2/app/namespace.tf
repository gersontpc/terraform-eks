resource "kubernetes_namespace" "fargate" {
  metadata {
    labels = {
      app = "app-hello-k8s"
    }
    name = "fargate-node"
  }
}