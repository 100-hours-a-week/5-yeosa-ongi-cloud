variable "bucket_name" {
  type        = string
  description = "생성할 GCS 버킷 이름 (전역 고유)"
}

variable "project_id" {
  type        = string
  description = "GCP 프로젝트 ID"
}

variable "location" {
  type        = string
  default     = "ASIA-NORTHEAST3"
  description = "버킷 리전"
}

variable "storage_class" {
  type        = string
  default     = "STANDARD"
  description = "스토리지 클래스 (예: STANDARD, NEARLINE, COLDLINE)"
}

variable "versioning" {
  type        = bool
  default     = false
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "true이면 버킷 안의 객체가 있어도 삭제 가능"
}
