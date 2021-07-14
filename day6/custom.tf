resource "google_project_iam_custom_role" "custom_role" {
  role_id     = "custom_role"
  title       = "get"
  project     = "gcp-lab-1-ym"
  stage       = "ALPHA"
  description = "get files from all bucket and info abou VMs in project"
  permissions = ["storage.buckets.get", "compute.instances.get",
   "storage.buckets.list", "compute.instances.list"]
}

resource "google_service_account" "mikhalchuk-gke" {
  account_id    = "mikhalchuk-gke"
  display_name  = "mikhalchuk-gke"
}

resource "google_project_iam_member" "mikhalchuk-gke" {
  role   = google_project_iam_custom_role.custom_role.id
  member = "serviceAccount:${google_service_account.mikhalchuk-gke.email}"
}

resource "google_container_cluster" "ym-gke-cluster" {
  name                      = "ym-gke-cluster"
  location                  = "us-central1"
  remove_default_node_pool  = true
  initial_node_count        = 1
  workload_identity_config {
    identity_namespace      = "gcp-lab-1-ym.svc.id.goog"
  }
}

module "my-app-workload-identity" {
  source        = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  cluster_name  = google_container_cluster.ym-gke-cluster.name
  name          = "ymgkeservice"
  namespace     = kubernetes_namespace.nginxns.metadata.0.name
  project_id    = "gcp-lab-1-ym"
  roles         = ["projects/gcp-lab-1-ym/roles/custom_role"]
}

resource "google_container_node_pool" "nginx-noge-pool" {
  name          = "nginx-node-pool"
  location      = "us-central1"
  cluster       = google_container_cluster.ym-gke-cluster.name
  node_count    = 1

  node_config {
    machine_type = "custom-1-1024"
  }
}