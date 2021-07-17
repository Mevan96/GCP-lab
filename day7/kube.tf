resource "kubernetes_namespace" "mysql" {
  metadata {
    name = "mysql"
  }
}

resource "kubernetes_secret" "mysql-secret" {
  metadata {
    name = "mysql-auth"
    namespace = kubernetes_namespace.mysql.metadata.0.name
  }
  data   = {
    password = random_password.password.result
  }
}

resource "kubernetes_config_map" "mysql-script" {
  metadata {
    name = "mysql-script"
    namespace = kubernetes_namespace.mysql.metadata.0.name
  }
  data = {
    "sql_script.sql" = "${file("sql_script.sql")}"
  }
}

resource "kubernetes_deployment" "mysql-deployment" {
  metadata {
    name = "mysql-deployment"
    namespace = kubernetes_namespace.mysql.metadata.0.name
    labels    = {
      app     = "mysql"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "mysql"
      }
    }
    template {
      metadata {
        labels = {
          app  = "mysql"
        }
      }
      spec {
        container {
          image   = "gcr.io/cloudsql-docker/gce-proxy:1.20.0"
          name    = "mysql-instance"
          command = ["/cloud_sql_proxy", "-instances=${google_sql_database_instance.instance.connection_name}=tcp:3306"]
        }
        container {
          image   = "google/cloud-sdk"
          name    = "mysql-client"
          command = ["bash", "-c", "apt-get install -y default-mysql-client; mysql --password=$MYSQLPASSWORD --user=ym --host=127.0.0.1 --port=3306 --database=${google_sql_database.database.name} < /home/cloudsdk/sql_script.sql; sleep 10000"]
          env {
            name = "MYSQLPASSWORD"
            value_from {
              secret_key_ref {
                key  = "password"
                name = kubernetes_secret.mysql-secret.metadata.0.name
              }
            }
          }
          volume_mount {
            name = "workdir"
            mount_path = "/home/cloudsdk"
          }
        }
        service_account_name = module.workload-identity.k8s_service_account_name
        volume {
          name = "workdir"
          config_map {
            name = kubernetes_config_map.mysql-script.metadata.0.name
            items {
              key  = "sql_script.sql"
              path = "sql_script.sql"
            }
          }
        }
      }
    }
  }
}