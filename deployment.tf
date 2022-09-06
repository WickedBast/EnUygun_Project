resource "kubernetes_deployment" "wordpress-deployment" {
  metadata {
    name = "wordpress-deployment"
    labels = {
      app = "wordpress"
    }
  }

  spec {
    
    replicas = 1

    selector {
      match_labels = {
        app = "wordpress"
      }
    }

    template {
      metadata {
        labels = {
          app = "wordpress"
        }
      }

      spec {

          container {

            image = "wordpress"
            name  = "wordpress"

            env {
                  name = "WORDPRESS_DB_HOST"
                  value = "127.0.0.1:3306"
            }

            env {
                  name = "WORDPRESS_DB_USER"
                  value_from {
                      secret_key_ref {
                          name = kubernetes_secret.cloudsql-db-credentials-terraform.metadata.0.name
                          key = "username"
                      }  
                  }
            }

            env {
                  name = "WORDPRESS_DB_PASSWORD"
                  value_from  {
                      secret_key_ref  {
                          name = kubernetes_secret.cloudsql-db-credentials-terraform.metadata.0.name
                          key = "password"
                      }  
                  }
            }

            port {
              name           = "http"
              container_port = 80
              protocol       = "TCP"
            }

            volume_mount {
              mount_path = "/var/www/html"
              name       = "wordpress-persistent-storage"
            }
            
            

          }
          
          container { 
            image = "gcr.io/cloudsql-docker/gce-proxy:1.11"
            name  = "cloudsql-proxy"

            command = ["/cloud_sql_proxy", 
            "-instances=${google_sql_database_instance.cloudsql.connection_name}=tcp:3306",
            "-credential_file=/secrets/cloudsql/key.json"]
            
            security_context {
                run_as_user = 2 
                allow_privilege_escalation = "false"
            }

            volume_mount {
                mount_path = "/secrets/cloudsql"
                name       = "cloudsql-instance-credentials-terraform"
                read_only  = "true"
            }



          }

        volume {
            name = "wordpress-persistent-storage"
            persistent_volume_claim {
              claim_name = "wordpress-pvc"
            } 
        }

        volume {
            name = "cloudsql-instance-credentials-terraform"
            secret {
                secret_name = "cloudsql-instance-credentials-terraform"
            }
        }
        
        }
      }
}
}