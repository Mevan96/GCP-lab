project         = "gcp-lab-1-ym"
name            = "nginx-terraform"
zone            = "us-central1-a"
image_family    = "centos-7"
machine_type    = "n1-custom-1-4608"
network         = "yauhen-mikhalchuk-vpc"   
subnetwork      = "public-subnetwork"
install         = "sudo yum install -y nginx; sudo systemctl enable nginx; sudo systemctl start nginx; echo 'Hello form Yauhen Mikhalchuk!' > /usr/share/nginx/html/index.html "