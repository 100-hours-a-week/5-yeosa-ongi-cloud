variable "vpc_name" {
  description = "VPC 이름"
  type        = string
}

# 단일 서브넷 (옵션 사용 가능)
variable "subnet_enabled" {
  description = "단일 서브넷 사용 여부"
  type        = bool
  default     = false
}

variable "subnet_name" {
  description = "단일 서브넷 이름"
  type        = string
  default     = ""
}

variable "ip_cidr_range" {
  description = "단일 서브넷 CIDR"
  type        = string
  default     = ""
}

