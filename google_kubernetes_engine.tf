resource "google_container_cluster" "gke-terraform" {
  name     = "gke-terraform"
  location = var.zone
  initial_node_count = 1

  network    = google_compute_network.terraform-network.name
  subnetwork = google_compute_subnetwork.terraform-subnet.name
}