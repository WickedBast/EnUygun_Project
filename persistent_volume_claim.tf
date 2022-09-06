resource "google_compute_disk" "terraform-pd" {
  name  = "terraform-disk"
  type  = "pd-standard"
  zone  = "europe-west3-c"
}

resource "kubernetes_persistent_volume" "terraform-pv" {

  metadata {
    name = "wordpress-pv"
  }
  spec {
    capacity = {
      storage = "5Gi"
    }
    storage_class_name = "standard"
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      gce_persistent_disk {
        pd_name = google_compute_disk.terraform-pd.name
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "terraform-pvc" {
  metadata {
    name = "wordpress-pvc"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    storage_class_name = "standard"
    resources {
      requests = {
        storage = "5Gi"
      }
    }
    volume_name = kubernetes_persistent_volume.terraform-pv.metadata.0.name
  }
}