resource "google_service_account_key" "cloudsql-proxy-key" {
  service_account_id = google_service_account.cloudsql-proxy-terraform.name
}

resource "kubernetes_secret" "cloudsql-instance-credentials-terraform" {
  metadata {
    name = "cloudsql-instance-credentials-terraform"
  }
  data = {
    "key.json" = base64decode(google_service_account_key.cloudsql-proxy-key.private_key)
  }
}

resource "kubernetes_secret" "cloudsql-db-credentials-terraform" {
  metadata {
    name = "cloudsql-db-credentials-terraform"
  }
  data = {
    "username" = "wordpress"
    "password" = random_password.wordpress-cloudsql-password.result
  }
}