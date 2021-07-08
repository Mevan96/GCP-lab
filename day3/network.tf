resource "google_compute_subnetwork" "public-subnetwork" {
  name                      = "public-subnetwork"
  ip_cidr_range             = "10.6.1.0/24"
  region                    = "us-central1"
  network                   = google_compute_network.vpc_network.id
  description               = "public subnet for vpc_network"
}

resource "google_compute_subnetwork" "private-subnet" {
  name                      = "private-subnet"
  ip_cidr_range             = "10.6.2.0/24"
  region                    = "us-central1"
  network                   = google_compute_network.vpc_network.id
  description               = "private subnet for vpc_network"
}

resource "google_compute_network" "vpc_network" {
  name                      = "yauhen-mikhalchuk-vpc"
  description               = "custom network for day 3 task"
  auto_create_subnetworks   = false
}