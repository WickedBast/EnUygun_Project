resource "google_compute_network" "terraform-network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "terraform-subnet" {
  name          = "terraform-subnet"
  region        = var.region
  network       = google_compute_network.terraform-network.name
  ip_cidr_range = "10.0.0.0/24"

}
