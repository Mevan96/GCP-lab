resource "google_compute_instance_template" "template-private" {
  name         = "template-private"
  project      = var.project
  region       = var.region
  machine_type = var.machine_type

  disk {
    source_image = var.image_family
    auto_delete  = true
    disk_size_gb = 20
    boot         = true
  }

  network_interface {
    network            = var.network
    subnetwork         = var.pri_subnetwork
    subnetwork_project = var.project
  }
}

resource "google_compute_region_instance_group_manager" "appserver" {
  name = "appserver-igm"

  base_instance_name = "tomcat-cloudproxy"

  version {
    instance_template = google_compute_instance_template.template-private.id
  }

  distribution_policy_zones = ["us-central1-a", "us-central1-b", "us-central1-c"]
  target_size               = var.count_instance

  named_port {
    name = "http"
    port = 8081
  }

  named_port {
    name = "custom"
    port = 5432
  }

  named_port {
    name = "ssh"
    port = 22
  }
}