variable "firewall_name" {
  type = string
}

variable "vpc" {
  type = string
}

variable "target_tags" {
  type = list(string)
}

variable "source_ranges" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "allowed_ports" {
  type        = list(string)
  description = "List of allowed TCP ports"
}

