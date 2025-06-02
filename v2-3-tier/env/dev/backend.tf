terraform {
  backend "gcs" {
    bucket = "dev-ongi-terraform-state"
    prefix = "v2-3-tier/dev"
  }
}
