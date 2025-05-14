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
variable "firewall_name" {
  description = "Name of the firewall rule"
  type        = string
}

variable "target_tags" {
  description = "Target tags for firewall rule"
  type        = list(string)
}

variable "allowed_ports" {
  description = "List of allowed TCP ports"
  type        = list(string)
}