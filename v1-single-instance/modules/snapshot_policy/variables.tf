variable "zone" {
  description = "GCP zone"
  type        = string
}

variable "web_snapshot_policy" {
  description = "Name of the snapshot policy for the web instance"
  type        = string
}

variable "ai_snapshot_policy" {
  description = "Name of the snapshot policy for the AI instance"
  type        = string
}

variable "web_boot_disk_name" {
  description = "Name of the boot disk for the web instance"
  type        = string
}

variable "ai_boot_disk_name" {
  description = "Name of the boot disk for the AI instance"
  type        = string
}