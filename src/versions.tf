terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.4"
    }
  }
  required_version = ">= 0.14"
}