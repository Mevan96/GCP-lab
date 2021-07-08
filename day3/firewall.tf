resource "google_compute_firewall" "ingress-firewall" {
  name          = "ingress-firewall"
  network       = google_compute_network.vpc_network.name
  direction     = "INGRESS"
  description   = "internal all ports access"
  
  allow {
    protocol    = "tcp"
    ports       = ["0-65535"]
  }
}

resource "google_compute_firewall" "egress-firewall" {
  name          = "egress-firewall"
  network       = google_compute_network.vpc_network.name
  direction     = "EGRESS"
  description   = "internet access by 22 80 ports"

  allow {
    protocol    = "tcp"
    ports       = ["80", "22"]
  }
}
