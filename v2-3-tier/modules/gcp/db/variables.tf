variable "db_tier" {
  type        = string
  description = "DB 인스턴스 스펙"
}

variable "database_version" {
  type        = string
  description = "DB 버전"
}

variable "master_name" {
  type = string
}

variable "replica_name" {
  type = string
}

variable "vpc_self_link" {
  type = string
}
