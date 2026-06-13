locals {
  windows_to_ansible_public_key = trimspace(file(var.ssh_public_key_path))
  ansible_to_k3s_public_key     = trimspace(file(var.ansible_to_k3s_public_key_path))

  ansible_ctrl_cloud_init = templatefile("${path.module}/cloud-init.yaml.tpl", {
    hostname       = local.ansible_ctrl_name
    username       = var.ansible_ctrl_vm_user
    ssh_public_key = local.windows_to_ansible_public_key
  })

  k3s_master_cloud_init = templatefile("${path.module}/cloud-init.yaml.tpl", {
    hostname       = local.k3s_master_name
    username       = var.k3s_vm_user
    ssh_public_key = local.ansible_to_k3s_public_key
  })

  k3s_worker_01_cloud_init = templatefile("${path.module}/cloud-init.yaml.tpl", {
    hostname       = local.k3s_worker_01
    username       = var.k3s_vm_user
    ssh_public_key = local.ansible_to_k3s_public_key
  })

  k3s_worker_02_cloud_init = templatefile("${path.module}/cloud-init.yaml.tpl", {
    hostname       = local.k3s_worker_02
    username       = var.k3s_vm_user
    ssh_public_key = local.ansible_to_k3s_public_key
  })
}

output "ansible_ctrl_cloud_init_preview" {
  description = "Rendered cloud-init for Ansible control node"
  value       = local.ansible_ctrl_cloud_init
  sensitive   = true
}