variable "name" {
  description = "이 ALB 리소스의 이름 prefix"
  type        = string
}

variable "instance_group" {
  description = "백엔드 인스턴스 그룹의 self_link"
  type        = string
}

variable "health_check_port" {
  description = "헬스체크에 사용할 포트"
  type        = number
  default     = 8080
}

variable "health_check_path" {
  description = "헬스체크 경로"
  type        = string
  default     = "/"
}

variable "default_path_target" {}
variable "backend_bucket" {}
variable "api_path_prefix" {}
variable "static_path_prefix" {}