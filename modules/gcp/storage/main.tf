resource "google_storage_bucket" "bucket" {
  name     = var.bucket_name
  location = var.location
  project  = var.project_id

  storage_class = var.storage_class

  uniform_bucket_level_access = true  # 권장: IAM 기반 권한 제어

  versioning {
    enabled = var.versioning
  }

  force_destroy = var.force_destroy
}