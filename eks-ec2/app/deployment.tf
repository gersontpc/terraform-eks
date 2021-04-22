resource "kubernetes_deployment" "app" {
  metadata {
    name      = "hello-kubernetes"
    namespace = "fargate-node"
    labels = {
      app = "app-hello-k8s"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "app-hello-k8s"
      }
    }

    template {
      metadata {
        labels = {
          app = "app-hello-k8s"
        }
      }

      spec {
        container {
          image = "gersontpc/hello-k8s:latest"
          name  = "hello-kubernetes"

          port {
            container_port = 8080
          }
        }
      }
    }
  }
  depends_on = [kubernetes_namespace.fargate]

}