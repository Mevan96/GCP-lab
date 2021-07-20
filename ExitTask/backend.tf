terraform {
  backend "gcs" {
    bucket = "gcp-lab-1-ym-cfg-bucket"
    prefix = "terraform/state"
  }
}