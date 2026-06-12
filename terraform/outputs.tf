output "ansible_ctrl_name" {
  description = "Generated Ansible control node name"
  value       = local.ansible_ctrl_name
}

output "k3s_master_name" {
  description = "Generated k3s master node name"
  value       = local.k3s_master_name
}

output "k3s_worker_names" {
  description = "Generated k3s worker node names"
  value = [
    local.k3s_worker_01,
    local.k3s_worker_02
  ]
}

output "ansible_ctrl_id" {
  description = "Ansible control node VM ID"
  value       = cloudru_evolution_compute_vm.ansible_ctrl.id
}

output "ansible_ctrl_internal_ip" {
  description = "Ansible control node internal IP"
  value       = cloudru_evolution_compute_interface.ansible_ctrl.ip_address
}

output "ansible_ctrl_public_ip" {
  description = "Ansible control node public IP"
  value       = cloudru_evolution_compute_interface.ansible_ctrl.external_ip.ip_address
}

output "ansible_ctrl_ssh_command" {
  description = "SSH command for Ansible control node"
  value       = "ssh -i ${replace(var.ssh_public_key_path, ".pub", "")} ${var.ansible_ctrl_vm_user}@${cloudru_evolution_compute_interface.ansible_ctrl.external_ip.ip_address}"
}