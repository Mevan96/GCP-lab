resource "google_storage_bucket" "nearline-bucket"{
    name            = "ym-nearline-bucket"
    storage_class   = "NEARLINE"
    location        = "EU"

    lifecycle_rule {
        condition {
            age = 2
    }
        action {
            type            = "SetStorageClass"
            storage_class   = "COLDLINE"
    }
  }
}

resource "google_storage_bucket" "coldline-bucket"{
    name            = "ym-coldline-bucket"
    storage_class   = "COLDLINE"
    location        = "EU"

    lifecycle_rule {
        condition {
            age = 3
    }
        action {
            type = "Delete"
    }
  }
}