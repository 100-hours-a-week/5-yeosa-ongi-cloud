variable "instance_name" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "boot_image" {
  type = string
}

variable "boot_disk_size" {
  type = number
}

variable "subnet_self_link" {
  type = string
}

variable "tags" {
  type    = list(string)
  default = []
}

