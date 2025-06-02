variable "firewall_name" {
  type = string
}

variable "vpc" {
  type = string
}

variable "target_tags" {
  type = list(string)
}

variable "source_tags" {
  type        = list(string)
  description = "List of source tags to allow traffic from"
  default     = null
}

variable "source_ranges" {
  type        = list(string)
  description = "List of source IP ranges to allow traffic from"
  default     = null
}

variable "allow_tcp_ports" {
  description = "List of TCP ports to allow"
  type        = list(string)
  default     = null
}

variable "allow_udp_ports" {
  description = "List of UDP ports to allow"
  type        = list(string)
  default     = null
}