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
  vpc             = module.vpc.vpc_name
  subnet          = module.vpc.subnet_self_link
  tags            = var.web_tags
  startup_script  = var.web_startup_script
  application_yml = var.web_application_yml
}

# AI 인스턴스
module "ai_instance" {
  source          = "../../../modules/gcp/instance"
  instance_name   = var.ai_instance_name
  zone            = var.zone
  machine_type    = var.ai_machine_type
  boot_image      = var.ai_boot_image
  vpc             = module.vpc.vpc_name
  subnet          = module.vpc.subnet_self_link
  tags            = var.ai_tags
  startup_script  = var.ai_startup_script
  application_yml = var.ai_application_yml
}

module "firewall" {
  source        = "../../../modules/gcp/firewall"
  firewall_name = var.firewall_name
  vpc           = module.vpc.vpc_name
  target_tags   = var.target_tags
  allowed_ports  = var.allowed_ports
}