project = "gcp-lab-1-ym"
network = "default"
name = "nginx-terraform"
zone = "us-central1-c"
image_family = "centos-7"
disk_type = "pd-ssd"
disk_size = 35
machine_type = "n1-custom-1-4608"
labels = {
        server_type = "nginx_server"
        os_family = "redhat"
        way_of_installation = "terraform"
}