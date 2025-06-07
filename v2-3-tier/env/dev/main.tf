module "vpc" {
  source                = "../../modules/gcp/vpc"
  vpc_name              = "dev-ongi-vpc"
  openvpn_subnet_name   = "dev-ongi-openvpn-subnet"
  server_subnet_name    = "dev-ongi-server-subnet"
  openvpn_ip_cidr_range = "10.0.10.0/24"
  server_ip_cidr_range  = "10.0.20.0/24"
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
  source_ranges   = ["${module.cdn.cdn_ip_address}/32"]
  target_tags     = ["dev-backend"]
}

module "firewall_allow_hc_backend" {
  source          = "../../modules/gcp/firewall"
  firewall_name   = "dev-firewall-hc-backend"
  vpc             = module.vpc.vpc_name
  allow_tcp_ports = ["8080"]
  source_ranges   = [
    "35.191.0.0/16",
    "130.211.0.0/22"
  ]
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

module "firewall_allow_ssh_wireguard" {
  source          = "../../modules/gcp/firewall"
  firewall_name   = "dev-firewall-wireguard"
  vpc             = module.vpc.vpc_name
  allow_udp_ports = ["51820"]
  source_ranges   = ["0.0.0.0/0"]
  target_tags     = ["dev-shared"]
}

module "firewall_allow_mysql" {
  source          = "../../modules/gcp/firewall"
  firewall_name   = "dev-firewall-mysql"
  vpc             = module.vpc.vpc_name
  allow_tcp_ports = ["3306"]
  source_tags = ["dev-backend"]
  destination_ranges = ["10.32.176.3/32"]
}

module "shared_instance" {
  source           = "../../modules/gcp/openvpn"
  zone             = var.zone
  instance_name    = "dev-vm-openvpn"
  machine_type     = "e2-micro"
  boot_image       = "ubuntu-os-cloud/ubuntu-2004-lts"
  subnet_self_link = module.vpc.subnet_openvpn_self_link
  
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

module "backend" {
  source                 = "../../modules/gcp/backend-service"
  name                   = "dev-vm-backend"
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

module "ai" {
  source = "../../modules/gcp/ai-service"
  name                   = "dev-vm-ai"
  region                 = var.region
  zones                  = var.zones
  machine_type           = "e2-medium"
  source_image           = "ubuntu-os-cloud/ubuntu-2004-lts"
  subnetwork             = module.vpc.subnet_server_self_link
  initial_size           = 1
  min_replicas           = 1
  max_replicas           = 5
  cpu_utilization_target = 0.6
  service_port           = 8000
  tags                   = ["dev-ai"]
}

# module "alb" {
#   source            = "../../modules/gcp/alb"
#   name              = "dev-ongi"
#   instance_group    = module.backend.backend_service_instance_group
#   health_check_port = 8080
#   health_check_path = "/actuator/health"

#   backend_bucket      = module.cdn.backend_bucket
#   default_path_target = module.cdn.backend_bucket
# }

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
  bucket_name          = module.frontend_bucket.bucket_name
  cdn_name             = "dev-cdn"
  backend_name         = "dev-backend"
  domain               = var.domain_name
  api_path_prefix      = "/api/*"
  static_path_prefix   = "/cdn/*"
  health_check_port    = 8080
  health_check_path    = "/actuator/health"
  instance_group       = module.backend.backend_service_instance_group
}

module "dns" {
  source      = "../../modules/gcp/dns"
  zone_name   = "ongi-zone"
  domain_name = var.domain_name
  subdomain   = "dev"
  ip_address  = module.cdn.cdn_ip_address
}

# WAF 적용
