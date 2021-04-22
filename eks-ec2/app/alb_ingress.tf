resource "kubernetes_ingress" "app" {
  metadata {
    name      = "hello-k8s-lb"
    namespace = "fargate-node"
    annotations = {
      "kubernetes.io/ingress.class"           = "alb"
      "alb.ingress.kubernetes.io/scheme"      = "internet-facing"
      "alb.ingress.kubernetes.io/target-type" = "ip"
    }
    labels = {
        "app" = "owncloud"
    }
  }

  spec {
      backend {
        service_name = "hellok8snlb"
        service_port = 80
      }
    rule {
      http {
        path {
          path = "/"
          backend {
            service_name = "hellok8snlb"
            service_port = 80
          }
        }
      }
    }
  }

  depends_on = [kubernetes_service.app]
}