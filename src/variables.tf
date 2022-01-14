variable "proxmox_host_api" {
  type = map(any)
  default = {
    proxmox_ip          = "10.10.10.10"
    proxmox_port        = "8006"
    pm_api_token_id     = ""
    pm_api_token_secret = ""
    target_node         = "pve"
  }
  sensitive = true
}


variable "ostemplate" {
  type    = string
  default = "shared:vztmpl/centos-7-default_20171212_amd64.tar.xz"
}

variable "nesting" {
  type    = bool
  default = false
}

variable "unprivileged" {
  type    = bool
  default = true
}

variable "memory" {
  type    = number
  default = 4096
}

variable "rootfs" {
  type        = map(any)
  description = "Container filesystem"
  default = {
    storage = "local-lvm"
    size    = "8G"
  }
}

variable "hostname" {
  type = string
}

variable "host_password" {
  type      = string
  sensitive = true
}

variable "hardware_addr" {
  type = string
}

variable "ssh_public_keys" {
  type        = string
  description = "Path to file containing SSH authorized keys"
}