variable "zone" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "boot_image" {
  type = string
}

variable "subnet_self_link" {
  type = string
}

variable "startup_script" {
  type    = string
  default = ""
}

variable "tags" {
  type    = list(string)
  default = []
}
