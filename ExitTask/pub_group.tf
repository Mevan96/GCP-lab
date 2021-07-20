resource "google_compute_instance" "nginx_terra" {
  project      = var.project
  zone         = "us-central1-b"
  name         = var.name
  machine_type = var.machine_type
  description  = "This is nginx-terraform."

  boot_disk {
    initialize_params {
      image = var.image_family
    }
  }

  network_interface {
    network            = var.network
    subnetwork         = var.pub_subnetwork
    subnetwork_project = var.project
  }

  metadata_startup_script = var.install
}

resource "google_compute_instance_group" "nginx-group" {
  name        = "nginx-group"
  project     = var.project
  description = "Terraform nginx instance group"

  instances = [
    google_compute_instance.nginx_terra.id,
  ]

  named_port {
    name = "http"
    port = "80"
  }
}

resource "google_compute_backend_service" "nginx_service" {
  name      = "nginx-service"
  port_name = "http"
  protocol  = "HTTP"

  backend {
    group = google_compute_instance_group.nginx-group.id
  }

  health_checks = [
    google_compute_http_health_check.nginx_health.id,
  ]
}

resource "google_compute_http_health_check" "nginx_health" {
  name         = "nginx-health"
  request_path = "/"
}