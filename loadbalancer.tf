resource "kubernetes_service" "terraform-loadbalancer" {
  metadata {
    name = "terraform-loadbalancer"
  }
  spec {
    selector = {
        App = "wordpress"
    }
    port {
        port = 80
        target_port = 80
    }
    type = "LoadBalancer"
  }
}