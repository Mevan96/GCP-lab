resource "google_compute_global_address" "private_ip_address" {
  provider      = google-beta

  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = "projects/gcp-lab-1-ym/global/networks/default"
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider                = google-beta

  network                 = "projects/gcp-lab-1-ym/global/networks/default"
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_sql_database_instance" "instance" {
  provider          = google-beta

  name              = "ym-private-instance"
  region            = "us-central1"

  database_version  = "MYSQL_8_0"

  depends_on        = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier              = "db-f1-micro"
    availability_type = "REGIONAL"
    ip_configuration {
      ipv4_enabled    = false
      private_network = "projects/gcp-lab-1-ym/global/networks/default"
    }

    backup_configuration {
      enabled             = true
      binary_log_enabled  = true
    }
  }
}