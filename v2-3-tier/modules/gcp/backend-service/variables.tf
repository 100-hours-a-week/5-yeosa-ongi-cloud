variable "name" {}
variable "region" {
  type = string
}
variable "zones" {
  type = list(string)
}
variable "subnetwork" {
  type = string
}
variable "machine_type" {
  type = string
}
variable "source_image" {
  type = string
}
variable "initial_size" {
  type = number
}
variable "min_replicas" {
  type = number
}
variable "max_replicas" {
  type = number
}
variable "cpu_utilization_target" {
  type = number
}
variable "service_port" {
  type = number
}
variable "tags" {
  type = list(string)
}
