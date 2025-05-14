data "google_compute_address" "static_ip" {
  name   = "prod-ongi-web-ip"
  region = "asia-northeast3"
}