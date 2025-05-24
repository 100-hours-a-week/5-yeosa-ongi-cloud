variable "instance_name" {
  description = "VM 인스턴스 이름"
  type        = string
}

variable "zone" {
  description = "배포할 GCP 존"
  type        = string
}

variable "machine_type" {
  description = "머신 타입 (예: e2-medium)"
  type        = string
}

variable "boot_image" {
  description = "부트 디스크에 사용할 OS 이미지 (예: debian-cloud/debian-11)"
  type        = string
}

variable "boot_disk_size" {
  description = "Boot disk size in GB"
  type        = number# 기본값 50GB
}

variable "boot_disk_type" {
  description = "Boot disk type (pd-standard, pd-ssd, pd-balanced)"
  type        = string
}


variable "vpc" {
  description = "연결할 VPC 네트워크 이름"
  type        = string
}

variable "subnet" {
  description = "연결할 서브넷 self_link"
  type        = string
}

variable "tags" {
  description = "네트워크 태그 (방화벽에서 사용)"
  type        = list(string)
  default     = []
}

variable "assign_external_ip" {
  description = "외부 IP를 부여할지 여부"
  type        = bool
  default     = false
}

variable "use_static_ip" {
  description = "고정 IP를 사용할지 여부 (assign_external_ip=true일 때만 적용됨)"
  type        = bool
  default     = false
}