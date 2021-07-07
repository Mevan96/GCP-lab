variable project {}
variable network {}
variable zone {}
variable name {}
variable image_family {}
variable disk_type {}
variable machine_type {}
variable labels {}
variable disk_size {}


resource "google_compute_instance" "default" {
  project      = var.project
  zone         = var.zone
  name         = var.name
  machine_type = var.machine_type
  description = "This is nginx-terraform."

  boot_disk {
    initialize_params {
      image = var.image_family
      size = var.disk_size
      type = var.disk_type
    }
  }

  network_interface {
    network = var.network
    access_config {}
  }

  labels = var.labels

  metadata = {
      startup_script = "yum install nginx"
  }
  
  deletion_protection = true

  timeouts {
      delete = "40m"
  }
}

resource "google_compute_firewall" "default" {
  name    = "http-https"
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "443", "8443"]
  }
}

resource "google_compute_disk" "default" {
  name  = "test-disk"
  type  = "pd-ssd"
  zone  = "us-central1-c"
  image = "debian-9-stretch-v20200805"
  labels = {
    environment = "dev"
  }
  physical_block_size_bytes = 4096
}

resource "google_compute_attached_disk" "default" {
  disk     = google_compute_disk.default.id
  instance = google_compute_instance.default.id
}

output URL {
  value = "http://${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}/"
}
