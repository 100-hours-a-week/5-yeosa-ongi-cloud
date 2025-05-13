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

variable "startup_script" {
  description = "VM 시작 시 실행할 startup script"
  type        = string
}

variable "application_yml" {
  description = "BE-애플리케이션 설정 파일"
  type        = string
}
