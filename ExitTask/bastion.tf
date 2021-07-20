resource "google_compute_instance" "jump-host" {
  project      = var.project
  zone         = "us-central1-a"
  name         = "jump-host"
  machine_type = var.machine_type
  description  = "This is bastion."

  boot_disk {
    initialize_params {
      image = var.image_family
    }
  }

  network_interface {
    network            = var.network
    subnetwork         = var.pub_subnetwork
    subnetwork_project = var.project
    access_config {}
  }
}