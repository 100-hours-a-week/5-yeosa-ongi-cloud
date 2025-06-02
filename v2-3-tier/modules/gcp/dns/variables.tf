variable "zone_name" {
  description = "Cloud DNS managed zone name"
  type        = string
}

variable "domain_name" {
  description = "Root domain (e.g. ongi.today)"
  type        = string
}

variable "subdomain" {
  description = "Subdomain for A record (e.g. www, api)"
  type        = string
}

variable "ip_address" {
  description = "IP address to point the subdomain to"
  type        = string
}
