variable "vpc_name" {
  description = "VPC 이름 (라우터 이름 생성용)"
  type        = string
}

variable "router_name" {
  description = "라우터 이름"
  type        = string
}

variable "vpc_self_link" {
  description = "VPC self link (라우터 연결용)"
  type        = string
}

variable "nat_name" {
  description = "NAT 이름"
  type        = string
}

variable "nat_ip_allocate_option" {
  description = "NAT IP 할당 옵션"
  type        = string
}

variable "source_subnetwork_ip_ranges_to_nat" {
  description = "NAT 소스 서브넷 IP 범위"
  type        = string
}

variable "log_config_enable" {
  description = "로그 활성화 여부"
  type        = bool
}
