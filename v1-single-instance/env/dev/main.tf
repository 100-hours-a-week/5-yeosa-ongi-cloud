provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

module "vpc" {
  source        = "../../modules/gcp/vpc"
  vpc_name      = "dev-ongi-vpc"
  subnet_name   = "dev-ongi-subnet"
  ip_cidr_range = "10.10.10.0/24"
}

# 웹 인스턴스
module "web_instance" {
  source          = "../../modules/gcp/instance"
  instance_name   = "dev-ongi-web"
  zone            = var.zone
  machine_type    = "e2-medium"
  boot_image      = "ubuntu-os-cloud/ubuntu-2204-lts"
  boot_disk_size  = 30
  boot_disk_type  = "pd-standard"
  vpc             = module.vpc.vpc_name
  subnet          = module.vpc.subnet_self_link
  tags            = ["dev-web"]
  assign_external_ip = true
  use_static_ip  = true
}

module "ai_instance" {
  source          = "../../modules/gcp/instance"
  instance_name   = "dev-ongi-ai"
  zone            = var.zone
  machine_type    = "e2-standard-4"
  boot_image      = "ubuntu-os-cloud/ubuntu-2204-lts"
  boot_disk_size  = 40
  boot_disk_type  = "pd-standard"
  vpc             = module.vpc.vpc_name
  subnet          = module.vpc.subnet_self_link
  tags            = ["dev-ai"]
  assign_external_ip = false
}

module "firewall_allow_ai" {
  source        = "../../modules/gcp/firewall"
  firewall_name = "dev-allow-ai"
  vpc           = module.vpc.vpc_name
  allowed_ports = ["8000"]
  source_tags   = ["dev-web"]
  target_tags   = ["dev-ai"]
}

module "firewall_allow_web" {
  source        = "../../modules/gcp/firewall"
  firewall_name =  "dev-allow-web"
  vpc           = module.vpc.vpc_name
  allowed_ports = ["8080"]
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["dev-web"]
}

module "firewall_allow_http_ssh" {
  source        = "../../modules/gcp/firewall"
  firewall_name = "dev-allow-http-ssh"
  vpc           = module.vpc.vpc_name
  allowed_ports = ["22", "80", "443"]
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["dev-web", "dev-ai"]
}