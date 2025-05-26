provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

module "vpc" {
  source        = "../../modules/gcp/vpc"
  vpc_name      = "prod-ongi-vpc"
  subnet_name   = "prod-ongi-subnet"
  ip_cidr_range = "10.10.20.0/24"
}

# 웹 인스턴스
module "web_instance" {
  source          = "../../modules/gcp/instance"
  instance_name   = "prod-ongi-web"
  zone            = var.zone
  machine_type    = "e2-medium"
  boot_image      = "ubuntu-os-cloud/ubuntu-2204-lts"
  boot_disk_size  = 20
  boot_disk_type  = "pd-standard"
  vpc             = module.vpc.vpc_name
  subnet          = module.vpc.subnet_self_link
  tags            = ["http-server","https-server","prod-web"]
  assign_external_ip = true
  use_static_ip  = true
}

module "ai_instance" {
  source          = "../../modules/gcp/instance"
  instance_name   = "prod-ongi-ai"
  zone            = var.zone
  machine_type    = "n2d-standard-4"
  boot_image      = "ubuntu-os-cloud/ubuntu-2204-lts"
  boot_disk_size  = 40
  boot_disk_type  = "pd-standard"
  vpc             = module.vpc.vpc_name
  subnet          = module.vpc.subnet_self_link
  tags            = ["prod-ai"]
  assign_external_ip = true
  use_static_ip  = true
}

module "monitor_instance" {
  source          = "../../modules/gcp/instance"
  instance_name   = "prod-ongi-monitor"
  zone            = var.zone
  machine_type    = "e2-medium"
  boot_image      = "ubuntu-os-cloud/ubuntu-2204-lts"
  boot_disk_size  = 20
  boot_disk_type  = "pd-standard"
  vpc             = module.vpc.vpc_name
  subnet          = module.vpc.subnet_self_link
  tags            = ["prod-monitor"]
  assign_external_ip = true
  use_static_ip  = true
}

module "firewall_allow_ai" {
  source        = "../../modules/gcp/firewall"
  firewall_name = "prod-allow-ai"
  vpc           = module.vpc.vpc_name
  allowed_ports = ["8000"]
  source_tags   = ["prod-web"]
  target_tags   = ["prod-ai"]
}

module "firewall_allow_web" {
  source        = "../../modules/gcp/firewall"
  firewall_name =  "prod-allow-web"
  vpc           = module.vpc.vpc_name
  allowed_ports = ["8080"]
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["prod-web"]
}

module "firewall_allow_http_ssh" {
  source        = "../../modules/gcp/firewall"
  firewall_name = "prod-allow-http-ssh"
  vpc           = module.vpc.vpc_name
  allowed_ports = ["22", "80", "443"]
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["prod-web", "prod-ai"]
}

module "firewall_allow_prometheus" {
  source        = "../../modules/gcp/firewall"
  firewall_name = "prod-allow-prometheus"
  vpc           = module.vpc.vpc_name
  allowed_ports = ["9090"]
  source_ranges = ["211.244.225.0/24"]
  target_tags   = ["prod-monior"]
}

module "firewall_allow_grafana" {
  source        = "../../modules/gcp/firewall"
  firewall_name = "prod-allow-grafana"
  vpc           = module.vpc.vpc_name
  allowed_ports = ["3000"]
  source_ranges = ["211.244.225.0/24"]
  target_tags   = ["prod-monior"]
}

module "snapshot_policy" {
  source = "../../modules/gcp/snapshot_policy"
  zone          = var.zone
  web_snapshot_policy = "prod-web-snapshot-policy"
  ai_snapshot_policy  = "prod-ai-snapshot-policy"
  web_boot_disk_name = module.web_instance.boot_disk_name
  ai_boot_disk_name   = module.ai_instance.boot_disk_name
}