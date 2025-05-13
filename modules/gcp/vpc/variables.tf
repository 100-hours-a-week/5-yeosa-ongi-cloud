variable "vpc_name" {
  description = "VPC의 이름"
  type        = string
}

variable "subnet_name" {
  description = "서브넷 이름"
  type        = string
}

variable "ip_cidr_range" {
  description = "서브넷 IP CIDR 범위"
  type        = string
}

variable "region" {
  description = "리전을 지정 (예: asia-northeast3)"
  type        = string
}
