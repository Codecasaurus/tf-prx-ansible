locals {
  pm_api_url = "https://${var.proxmox_host_api["proxmox_ip"]}:${var.proxmox_host_api["proxmox_port"]}/api2/json"
}

provider "proxmox" {
  pm_tls_insecure     = true
  pm_api_url          = local.pm_api_url
  pm_api_token_id     = var.proxmox_host_api["pm_api_token_id"]
  pm_api_token_secret = var.proxmox_host_api["pm_api_token_secret"]
}


resource "proxmox_lxc" "lxc" {
  ostemplate   = var.ostemplate
  target_node  = var.proxmox_host_api["target_node"]
  unprivileged = var.unprivileged
  swap         = 0
  memory       = var.memory

  features {
    nesting = var.nesting
  }

  hostname        = var.hostname
  password        = var.host_password
  ssh_public_keys = file(var.ssh_public_keys)

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
    hwaddr = var.hardware_addr
  }

  rootfs {
    storage = var.rootfs["storage"]
    size    = var.rootfs["size"]
  }

  start  = true
  onboot = true

  connection {
    type  = "ssh"
    host  = var.hostname
    agent = true
  }

  provisioner "remote-exec" {
    # Wait for response before ansible exec
    inline = ["echo 'Ready for provisioning'"]
  }

  provisioner "local-exec" {
    working_dir = "./setup/"
    command     = "ansible-playbook -i '${var.hostname},' -u root setup.yml"
  }
}