resource "kubernetes_namespace" "nginxns" {
  metadata {
    name = "nginxns"
  }
}

resource "kubernetes_deployment" "nginx-deployment" {
  metadata {
    name = "nginx-deployment"
	namespace = kubernetes_namespace.nginxns.metadata.0.name
    labels = {
      app = "nginx"
    }
  }
  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "nginx"
      }
    }
    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }
      spec {
        init_container {
          image = "google/cloud-sdk"
          name  = "init-gcloud"
          command = ["bash", "-c", "gsutil cp gs://mikhalchuk-config-bucket/index.html /workdir/index.html"]
          volume_mount {
            name = "workdir"
            mount_path = "/workdir"
          }
        }
        container {
          image = "nginx:1.14.2"
          name  = "nginx"
          port {
            container_port = 80
          }
          volume_mount {
            name = "workdir"
            mount_path = "/usr/share/nginx/html"
          }
        }
        service_account_name = module.my-app-workload-identity.k8s_service_account_name
        volume {
          name = "workdir"
          empty_dir {
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nginx-service" {
  metadata {
    name = "nginx-service"
	namespace = kubernetes_namespace.nginxns.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.nginx-deployment.metadata.0.labels.app
    }
    port {
      port  = 80
      target_port = 80
    }
    type = "NodePort"
  }
}

resource "kubernetes_ingress" "nginx-ingress" {
  metadata {
    name = "nginx-ingress"
	namespace = kubernetes_namespace.nginxns.metadata.0.name
  }
  spec {
    rule {
      http {
        path {
          backend {
            service_name = kubernetes_service.nginx-service.metadata.0.name
            service_port = 80
          }
          path = "/*"
        }
      }
    }
  }
}