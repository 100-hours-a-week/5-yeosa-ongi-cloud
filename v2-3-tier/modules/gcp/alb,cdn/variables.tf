variable "domain" {
  type        = string
  description = "GCP CDN 도메인 이름 (예: www.ongi.today)"
}
variable "bucket_name" {
  type        = string
  description = "GCP CDN 버킷 이름"
}

variable "cdn_name" {
  type        = string
  description = "GCP CDN 리소스 이름"
}

variable "backend_name" {
  type        = string
  description = "GCP 백엔드 이름"
}

variable "api_path_prefix" {
  type        = string
  description = "API 경로 접두사 (예: /api)"
}

variable "static_path_prefix" {
  type        = string
  description = "정적 파일 경로 접두사 (예: /cdn)"
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