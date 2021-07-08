variable project {}
variable zone {}
variable name {}
variable image_family {}
variable machine_type {}
variable network {}
variable subnetwork {}
variable install {}


resource "google_compute_instance" "default" {
  project       = var.project
  zone          = var.zone
  name          = var.name
  machine_type  = var.machine_type
  description   = "This is nginx-terraform."

  boot_disk {
    initialize_params {
      image         = var.image_family
    }
  }

  network_interface {
    network     = var.network
    subnetwork  = var.subnetwork
    access_config {}
  }
 
  metadata_startup_script = var.install
}