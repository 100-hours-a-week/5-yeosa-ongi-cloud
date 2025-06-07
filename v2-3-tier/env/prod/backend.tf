terraform {
  backend "gcs" {
    bucket = "ongi-terraform-state"
    prefix = "v2-3-tier/prod"
  }
}