locals {
  name_prefix = var.project_name

  ansible_ctrl_name = "${local.name_prefix}-ansible-ctrl-01"
  k3s_master_name   = "${local.name_prefix}-k3s-master-01"
  k3s_worker_01     = "${local.name_prefix}-k3s-worker-01"
  k3s_worker_02     = "${local.name_prefix}-k3s-worker-02"
}