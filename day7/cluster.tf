resource "google_container_cluster" "mysql-cluster" {
  name     = "mysql-cluster"
  location = "us-central1-c"
  project  = "gcp-lab-1-ym"
  ip_allocation_policy {}
  initial_node_count       = 1
  workload_identity_config {
    identity_namespace = "gcp-lab-1-ym.svc.id.goog"
  }
}

resource "google_container_node_pool" "mysql-noge-pool" {
  name       = "mysql-node-pool"
  location   = "us-central1-c"
  project  = "gcp-lab-1-ym"
  cluster    = google_container_cluster.mysql-cluster.name
  node_count = 1

  node_config {
    machine_type = "custom-1-4096"
  }
}

module "workload-identity" {
  source     = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  cluster_name = google_container_cluster.mysql-cluster.name
  name       = "mysqlservice"
  namespace  = kubernetes_namespace.mysql.metadata.0.name
  project_id = "gcp-lab-1-ym"
  roles = ["roles/cloudsql.admin"]
}