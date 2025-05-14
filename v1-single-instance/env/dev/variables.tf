variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "zone" {
  description = "GCP zone"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "ip_cidr_range" {
  description = "IP CIDR range for the subnet"
  type        = string
}

# Web instance variables
variable "web_instance_name" {
  description = "Name of the web instance"
  type        = string
}

variable "web_machine_type" {
  description = "Machine type for web instance"
  type        = string
}

variable "web_boot_image" {
  description = "Boot image for web instance"
  type        = string
}

variable "web_boot_disk_size" {
  description = "Boot disk size in GB"
  type        = number
}

variable "web_boot_disk_type" {
  description = "Boot disk type (pd-standard, pd-ssd, pd-balanced)"
  type        = string
}

variable "web_tags" {
  description = "Network tags for web instance"
  type        = list(string)
}

variable "web_startup_script" {
  description = "Startup script for web instance"
  type        = string
}

variable "web_application_yml" {
  description = "Application YAML configuration for web instance"
  type        = string
}

# AI instance variables
variable "ai_instance_name" {
  description = "Name of the AI instance"
  type        = string
}

variable "ai_machine_type" {
  description = "Machine type for AI instance"
  type        = string
}

variable "ai_boot_image" {
  description = "Boot image for AI instance"
  type        = string
}

variable "ai_boot_disk_size" {
  description = "Boot disk size in GB"
  type        = number
}

variable "ai_boot_disk_type" {
  description = "Boot disk type (pd-standard, pd-ssd, pd-balanced)"
  type        = string
}

variable "ai_tags" {
  description = "Network tags for AI instance"
  type        = list(string)
}

variable "ai_startup_script" {
  description = "Startup script for AI instance"
  type        = string
}

variable "ai_application_yml" {
  description = "Application YAML configuration for AI instance"
  type        = string
}

# Firewall variables
# AI Firewall (8000 포트)
variable "allow_ai_name" {
  description = "Name of the firewall rule for AI"
  type        = string
}

variable "allow_ai_ports" {
  description = "List of allowed ports for AI"
  type        = list(string)
}

variable "allow_ai_source_ranges" {
  description = "Source IP ranges for AI firewall"
  type        = list(string)
}

variable "allow_ai_target_tags" {
  description = "Target tags for AI firewall"
  type        = list(string)
}

# Web Firewall (8080 포트)
variable "allow_web_name" {
  description = "Name of the firewall rule for web"
  type        = string
}

variable "allow_web_ports" {
  description = "List of allowed ports for web"
  type        = list(string)
}

variable "allow_web_source_ranges" {
  description = "Source IP ranges for web firewall"
  type        = list(string)
}

variable "allow_web_target_tags" {
  description = "Target tags for web firewall"
  type        = list(string)
}

# Common Firewall (HTTP, HTTPS, SSH)
variable "allow_http_ssh_name" {
  description = "Name of the firewall rule for HTTP, HTTPS, and SSH"
  type        = string
}

variable "allow_http_ssh_ports" {
  description = "List of allowed ports for HTTP, HTTPS, and SSH"
  type        = list(string)
}

variable "allow_http_ssh_source_ranges" {
  description = "Source IP ranges for HTTP, HTTPS, and SSH firewall"
  type        = list(string)
}

variable "allow_http_ssh_target_tags" {
  description = "Target tags for HTTP, HTTPS, and SSH firewall"
  type        = list(string)
}