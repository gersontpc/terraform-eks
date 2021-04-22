resource "kubernetes_service" "app" {
  metadata {
    name      = "hello-kubernetes"
    namespace = "fargate-node"
  }
  spec {
    selector = {
      app = "app-hello-k8s"
    }

    port {
      port        = 8080
      target_port = 8080
      protocol    = "TCP"
    }

    type = "NodePort"
  }

  depends_on = [kubernetes_deployment.app]
}