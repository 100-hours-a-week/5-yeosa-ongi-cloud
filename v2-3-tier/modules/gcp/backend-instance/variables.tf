variable "instance_name" {
  type        = string
  description = "인스턴스 이름"
}

variable "machine_type" {
  type        = string
  description = "머신 타입 (예: e2-medium)"
}

variable "boot_image" {
  type        = string
  description = "OS 이미지 (예: debian-11)"
}

variable "boot_disk_size" {
  type        = number
  description = "부트 디스크 크기 (GB)"
}

variable "subnet_self_link" {
  type        = string
  description = "서브넷 self link (프라이빗 서브넷)"
}

variable "tags" {
  type        = list(string)
  default     = []
  description = "방화벽 규칙을 위한 네트워크 태그"
}