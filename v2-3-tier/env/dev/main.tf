module "vpc" {
  source                = "../../modules/gcp/vpc"
  vpc_name              = "dev-ongi-vpc"
  openvpn_subnet_name   = "dev-ongi-openvpn-subnet"
  server_subnet_name    = "dev-ongi-server-subnet"
  db_subnet_name        = "dev-ongi-db-subnet"
  openvpn_ip_cidr_range = "10.0.10.0/24"
  server_ip_cidr_range  = "10.0.20.0/24"
  db_ip_cidr_range      = "10.0.30.0/24"
}

# 방화벽
module "firewall_allow_ssh" {
  source          = "../../modules/gcp/firewall"
  firewall_name   = "dev-firewall-ssh"
  vpc             = module.vpc.vpc_name
  allow_tcp_ports = ["22"]
  source_ranges   = ["0.0.0.0/0"]
  target_tags     = ["dev-ai", "dev-backend", "dev-openvpn"]
}

module "firewall_allow_http_https" {
  source          = "../../modules/gcp/firewall"
  firewall_name   = "dev-firewall-http-https"
  vpc             = module.vpc.vpc_name
  allow_tcp_ports = ["80", "443"]
  source_ranges   = ["0.0.0.0/0"]
  target_tags     = ["dev-ai", "dev-backend", "dev-openvpn"]
}

module "firewall_allow_openvpn" {
  source          = "../../modules/gcp/firewall"
  firewall_name   = "dev-firewall-openvpn"
  vpc             = module.vpc.vpc_name
  allow_tcp_ports = ["1194"]
  allow_udp_ports = ["1194"]
  source_ranges   = ["0.0.0.0/0"]
  target_tags     = ["dev-openvpn"]
}

module "firewall_allow_backend" {
  source          = "../../modules/gcp/firewall"
  firewall_name   = "dev-firewall-backend"
  vpc             = module.vpc.vpc_name
  allow_tcp_ports = ["8080"]
  source_tags     = ["dev-openvpn"]
  target_tags     = ["dev-backend"]
}

module "firewall_allow_ai" {
  source          = "../../modules/gcp/firewall"
  firewall_name   = "dev-firewall-ai"
  vpc             = module.vpc.vpc_name
  allow_tcp_ports = ["8000"]
  source_tags     = ["dev-openvpn", "dev-backend"]
  target_tags     = ["dev-ai"]
}

module "openvpn_instance" {
  source           = "../../modules/gcp/openvpn"
  zone             = var.zone
  instance_name    = "dev-vm-openvpn"
  machine_type     = "e2-micro"
  boot_image       = "ubuntu-os-cloud/ubuntu-2004-lts"
  subnet_self_link = module.vpc.subnet_openvpn_self_link
  startup_script   = file("${path.module}/scripts/openvpn-startup.sh")
  tags             = ["dev-openvpn"]
}

module "nat" {
  source                             = "../../modules/gcp/nat"
  vpc_name                           = module.vpc.vpc_name
  vpc_self_link                      = module.vpc.vpc_self_link
  router_name                        = "dev-ongi-router"
  nat_name                           = "dev-ongi-nat"
  nat_ip_allocate_option             = "AUTO_ONLY"                     # 수동으로 고정 IP 할당
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES" # 모든 서브넷에 대해 NAT 적용
  log_config_enable                  = true                            # 로그 활성화
}

# 라우팅 테이블 서브넷 마다 필요한가?

# module "backend_instance" {
#   source                = "../../modules/gcp/backend-instance"
#   instance_name         = "dev-vm-backend"
#   machine_type          = "e2-medium" 
#   boot_image            = "ubuntu-os-cloud/ubuntu-2004-lts"
#   boot_disk_size        = 20 
#   subnet_self_link      = module.vpc.subnet_server_self_link
#   tags                  = ["dev-backend"]
# }

module "backend" {
  source                 = "../../modules/gcp/backend-service"
  name                   = "dev-ongi-backend"
  region                 = var.region
  zones                  = var.zones
  machine_type           = "e2-medium"
  source_image           = "ubuntu-os-cloud/ubuntu-2004-lts"
  subnetwork             = module.vpc.subnet_server_self_link
  initial_size           = 1
  min_replicas           = 1
  max_replicas           = 5
  cpu_utilization_target = 0.6
  service_port           = 8080
  tags                   = ["dev-backend"]
}

# module "mig" {
#   source                = "../../modules/gcp/mig"
#   name                  = "dev-ongi-mig"
#   region                = var.region
#   zones                 = var.zones
#   image                 = "ubuntu-os-cloud/ubuntu-2004-lts"
#   machine_type          = "e2-medium"
#   instance_tags         = ["dev-backend"]
#   subnetwork            = module.vpc.subnet_server_self_link
#   initial_size          = 1
#   min_replicas          = 1
#   max_replicas          = 5
#   cpu_target            = 0.6
#   service_port          = 8080
# }

module "alb" {
  source            = "../../modules/gcp/alb"
  name              = "dev-ongi"
  instance_group    = module.backend.backend_service_instance_group
  health_check_port = 8080
  health_check_path = "/actuator/health"

  api_path_prefix    = "/api/*"
  static_path_prefix = "/static/*"

  backend_bucket      = module.cdn.backend_bucket
  default_path_target = module.cdn.backend_bucket
}


# 프로젝트 분리
module "ai_instance" {
  source           = "../../modules/gcp/ai-instance"
  instance_name    = "dev-vm-ai"
  machine_type     = "n2d-standard-2" # 2 vCPU, 8GB RAM
  boot_image       = "ubuntu-os-cloud/ubuntu-2004-lts"
  boot_disk_size   = 35 # 50GB
  subnet_self_link = module.vpc.subnet_server_self_link
  tags             = ["dev-ai"]
}

# module "db" {
#   source = "../../modules/gcp/db"
#   master_name = "dev-master-db"
#   replica_name = "dev-replica-db"
#   vpc_self_link = module.vpc.vpc_self_link
#   database_version = "MYSQL_8_0" #버전변경 8.4
#   db_tier = "db-f1-micro"
# }

module "frontend_bucket" {
  source      = "../../modules/gcp/storage"
  bucket_name = "dev-ongi-frontend-bucket"
  region      = var.region
}

module "cdn" {
  source               = "../../modules/gcp/cdn"
  backend_bucket_name  = "dev-frontend-backend-bucket"
  bucket_name          = module.frontend_bucket.bucket_name
  url_map_name         = "dev-frontend-url-map"
  http_proxy_name      = "dev-frontend-http-proxy"
  https_proxy_name     = "dev-frontend-https-proxy"
  forwarding_rule_name = "dev-frontend-forwarding-rule"
  cdn_ip_address_name  = "dev-frontend-cdn-ip"
  domain               = var.domain_name
}

module "dns" {
  source      = "../../modules/gcp/dns"
  zone_name   = "ongi-zone"
  domain_name = var.domain_name
  subdomain   = "dev"
  ip_address  = module.cdn.cdn_ip_address
}

# WAF 적용
