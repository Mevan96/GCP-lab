resource "google_project_iam_custom_role" "custom-role" {
  role_id     = "customRole"
  title       = "get"
  description = "get files from all bucket and info abou VMs in project"
  permissions = ["storage.buckets.get", "compute.instances.get",
   "storage.buckets.list", "compute.instances.list"]
}

resource "google_service_account" "mikhalchuk-gke" {
  account_id    = "mikhalchuk-gke"
  display_name  = "mikhalchuk-gke"
}

resource "google_project_iam_member" "mikhalchuk-gke" {
  role   = google_project_iam_custom_role.custom-role.id
  member = "serviceAccount:${google_service_account.mikhalchuk-gke.email}"
}

resource "google_container_cluster" "ym-gke-cluster" {
  name                      = "ym-gke-cluster"
  location                  = "us-central1"
  remove_default_node_pool  = true
  initial_node_count        = 1
}

module "app-workload-identity" {
  source      = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  name        = "ym-application"
  project_id  = "gcp-lab-1-ym"
}

module "gke-workload-identity" {
  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  use_existing_k8s_sa = true
  name                = "mikhalchuk-gke"
  project_id          = "gcp-lab-1-ym"
}