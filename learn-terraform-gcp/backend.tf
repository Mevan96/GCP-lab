terraform {
 backend "gcs" {
   bucket  = "gcp-lab-1-ym"
   prefix  = "terraform/state"
 }
}
