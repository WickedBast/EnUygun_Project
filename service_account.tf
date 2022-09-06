resource "google_service_account" "cloudsql-proxy-terraform" {
  account_id   = "cloudsql-proxy-terraform"
  display_name = "cloudsql-proxy-terraform"
}

data "google_service_account" "cloudsql-proxy-terraform" {
  account_id = "cloudsql-proxy-terraform"
}

resource "google_project_iam_binding" "cloudsql-proxy-binding" {
  project = var.project
  role    = "roles/cloudsql.client"

  members = [
    "serviceAccount:${google_service_account.cloudsql-proxy-terraform.email}",
  ]
}