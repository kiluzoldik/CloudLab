locals {
  ssh_public_key = trimspace(file(var.ssh_public_key_path))

  ansible_ctrl_cloud_init = templatefile("${path.module}/cloud-init.yaml.tpl", {
    hostname       = local.ansible_ctrl_name
    username       = var.ansible_ctrl_vm_user
    ssh_public_key = local.ssh_public_key
  })
}

output "ansible_ctrl_cloud_init_preview" {
  description = "Rendered cloud-init for Ansible control node"
  value       = local.ansible_ctrl_cloud_init
  sensitive   = true
}