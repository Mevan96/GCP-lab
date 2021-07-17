data "google_client_config" "provider" {}

provider "google-beta" {
  project = "gcp-lab-1-ym"
  region  = "us-central1"
  zone    = "us-central1-c"
}

provider "kubernetes" {
  host = "https://${google_container_cluster.mysql-cluster.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.mysql-cluster.master_auth[0].cluster_ca_certificate)
}