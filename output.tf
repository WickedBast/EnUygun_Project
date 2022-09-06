output "lb_ip" {
  value = kubernetes_service.lb.load_balancer_ingress.0.ip
}
