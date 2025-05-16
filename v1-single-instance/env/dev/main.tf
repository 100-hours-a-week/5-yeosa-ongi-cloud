provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

module "vpc" {
  source        = "../../../modules/gcp/vpc"
  vpc_name      = var.vpc_name
  subnet_name   = var.subnet_name
  region        = var.region
  ip_cidr_range = var.ip_cidr_range
}

# 웹 인스턴스
module "web_instance" {
  source          = "../../../modules/gcp/instance"
  instance_name   = var.web_instance_name
  zone            = var.zone
  machine_type    = var.web_machine_type
  boot_image      = var.web_boot_image
  boot_disk_size  = var.web_boot_disk_size
  boot_disk_type  = var.web_boot_disk_type
  vpc             = module.vpc.vpc_name
  subnet          = module.vpc.subnet_self_link
  tags            = var.web_tags
  startup_script  = var.web_startup_script
  application_yml = var.web_application_yml
}
module "ai_instance" {
  source          = "../../../modules/gcp/instance"
  instance_name   = var.ai_instance_name
  zone            = var.zone
  machine_type    = var.ai_machine_type
  boot_image      = var.ai_boot_image
  boot_disk_size  = var.ai_boot_disk_size
  boot_disk_type  = var.ai_boot_disk_type
  vpc             = module.vpc.vpc_name
  subnet          = module.vpc.subnet_self_link
  tags            = var.ai_tags
  startup_script  = var.ai_startup_script
  application_yml = var.ai_application_yml
}

module "firewall_allow_ai" {
  source = "../../../modules/gcp/firewall"
  firewall_name = var.allow_ai_name
  vpc          = module.vpc.vpc_name
  allowed_ports = var.allow_ai_ports
  source_ranges = var.allow_ai_source_ranges
  target_tags   = var.allow_ai_target_tags
}

module "firewall_allow_web" {
  source = "../../../modules/gcp/firewall"
  firewall_name = var.allow_web_name
  vpc          = module.vpc.vpc_name
  allowed_ports = var.allow_web_ports
  source_ranges = var.allow_web_source_ranges
  target_tags   = var.allow_web_target_tags
}

module "firewall_allow_http_ssh" {
  source = "../../../modules/gcp/firewall"
  firewall_name = var.allow_http_ssh_name
  vpc          = module.vpc.vpc_name
  allowed_ports = var.allow_http_ssh_ports
  source_ranges = var.allow_http_ssh_source_ranges
  target_tags   = var.allow_http_ssh_target_tags
}
