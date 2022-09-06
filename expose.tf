resource "kubernetes_service" "service" {
    depends_on = [kubernetes_deployment.wwordpress-deployment]

    metadata {
        name = "terraform-service"
    }

    spec {
        selector = {
            app = kubernetes_deployment.wordpress-deployment.metadata.0.labels.app
        }
    
        port {
            port        = 8080
            target_port = 80
        }

        type = "NodePort"
    } 
      
}