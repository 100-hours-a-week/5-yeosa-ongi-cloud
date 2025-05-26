# Web 인스턴스용 스냅샷 정책 (3일 보관)
resource "google_compute_resource_policy" "web_snapshot_policy" {
  name   = var.web_snapshot_policy

  snapshot_schedule_policy {
    schedule {
      daily_schedule {
        days_in_cycle = 1
        start_time    = "03:00"
      }
    }

    retention_policy {
      max_retention_days    = 3
      on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
    }

    snapshot_properties {
      guest_flush = true
    }
  }
}

# AI 인스턴스용 스냅샷 정책 (1일 보관)
resource "google_compute_resource_policy" "ai_snapshot_policy" {
  name   = var.ai_snapshot_policy

  snapshot_schedule_policy {
    schedule {
      daily_schedule {
        days_in_cycle = 1
        start_time    = "03:00"
      }
    }

    retention_policy {
      max_retention_days    = 3
      on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
    }

    snapshot_properties {
      guest_flush = true
    }
  }
}
