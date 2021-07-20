resource "google_compute_global_forwarding_rule" "nginx_service" {
  name       = "global-rule"
  target     = google_compute_target_http_proxy.nginx_service.id
  port_range = "80"
}

resource "google_compute_target_http_proxy" "nginx_service" {
  name    = "test-proxy"
  url_map = google_compute_url_map.nginx_service.id
}

resource "google_compute_url_map" "nginx_service" {
  name            = "url-map"
  default_service = google_compute_backend_service.nginx_service.id

  host_rule {
    hosts        = ["gcp-lab-1-ym.com"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = google_compute_backend_service.nginx_service.id

    path_rule {
      paths   = ["/*"]
      service = google_compute_backend_service.nginx_service.id
    }
  }
}