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
  type = list(string)
  description = "List of source tags to allow traffic from"
  default = null  
}

variable "source_ranges" {
  type        = list(string)
  description = "List of source IP ranges to allow traffic from"
  default     = null
  
}

variable "allowed_ports" {
  type        = list(string)
  description = "List of allowed TCP ports"
}

