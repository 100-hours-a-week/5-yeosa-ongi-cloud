variable "backend_bucket_name" {
  type        = string
  description = "GCP CDN 백엔드 버킷 이름"
}

variable "domain" {
  type        = string
  description = "GCP CDN 도메인 이름 (예: www.ongi.today)"
}

variable "bucket_name" {
  type        = string
  description = "GCP CDN 버킷 이름"
}

variable "url_map_name" {
  type        = string
  description = "GCP CDN URL 맵 이름"
}

variable "http_proxy_name" {
  type        = string
  description = "GCP CDN HTTP 프록시 이름"
}

variable "https_proxy_name" {
  type        = string
  description = "GCP CDN HTTPS 프록시 이름"
}

variable "forwarding_rule_name" {
  type        = string
  description = "GCP CDN 포워딩 룰 이름"
}

variable "cdn_ip_address_name" {
  type        = string
  description = "GCP CDN IP 주소 이름"
}