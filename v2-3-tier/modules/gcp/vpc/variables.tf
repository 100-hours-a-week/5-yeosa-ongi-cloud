variable "vpc_name" {
  description = "VPC 이름"
  type        = string
}

variable "openvpn_subnet_name" {
  description = "OpenVPN 서브넷 이름"
  type        = string
}

variable "openvpn_ip_cidr_range" {
  description = "OpenVPN 서브넷 CIDR"
  type        = string
}

variable "server_subnet_name" {
  description = "서버 서브넷 이름"
  type        = string
}

variable "server_ip_cidr_range" {
  description = "서버 서브넷 CIDR"
  type        = string
}