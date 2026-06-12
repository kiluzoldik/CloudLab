data "cloudru_evolution_compute_vm_collection" "auth_check" {
  project_id = var.project_id
  page_size  = 1
}

output "auth_check_vm_count" {
  description = "Number of VMs returned by auth check"
  value       = try(length(data.cloudru_evolution_compute_vm_collection.auth_check.vms), 0)
}