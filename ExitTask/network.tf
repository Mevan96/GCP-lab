resource "google_compute_subnetwork" "public-subnetwork" {
  name          = var.pub_subnetwork
  ip_cidr_range = "10.6.1.0/24"
  region        = var.region
  project       = var.project
  network       = google_compute_network.vpc_network.id
  description   = "public subnet"
}

resource "google_compute_subnetwork" "private-subnet" {
  name          = var.pri_subnetwork
  ip_cidr_range = "10.6.2.0/24"
  region        = var.region
  project       = var.project
  network       = google_compute_network.vpc_network.id
  description   = "private subnet"
}

resource "google_compute_network" "vpc_network" {
  name                    = var.network
  description             = "custom network for exit task"
  project                 = var.project
  auto_create_subnetworks = false
}

resource "google_compute_firewall" "ingress-firewall" {
  name        = "ingress-firewall"
  network     = google_compute_network.vpc_network.name
  project     = var.project
  direction   = "INGRESS"
  description = "internal 80, 22, 5432, 8081 ports access"

  allow {
    protocol = "tcp"
    ports    = ["80", "22", "5432", "8081"]
  }
}

resource "google_compute_firewall" "egress-firewall" {
  name        = "egress-firewall"
  network     = google_compute_network.vpc_network.name
  project     = var.project
  direction   = "EGRESS"
  description = "internal access by 0-65535 ports"

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
}