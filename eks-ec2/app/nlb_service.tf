resource "kubernetes_service" "nlb" {
  metadata {
    name      = "hellok8snlb"
    namespace = "fargate-node"
  }
  spec {
    selector = {
      app = "app-hello-k8s"
    }

    port {
      port        = 80
      target_port = 8080
      protocol    = "TCP"
    }

    type = "LoadBalancer"
  }

  depends_on = [kubernetes_deployment.app]
}