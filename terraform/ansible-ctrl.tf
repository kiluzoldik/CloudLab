resource "cloudru_evolution_compute_disk" "ansible_ctrl" {
  project_id = var.project_id
  name       = "${local.ansible_ctrl_name}-disk"
  size       = var.ansible_ctrl_disk_size

  zone_identifier = {
    name = var.zone
  }

  disk_type_identifier = {
    name = var.disk_type
  }

  description = "Boot disk for Ansible control node"
  bootable    = true

  image_id = [
    for img in data.cloudru_evolution_compute_image_collection.ubuntu.images : img.id
    if img.name == "Ubuntu-24.04"
  ][0]

  encrypted = false
  readonly  = false
  shared    = false
}

resource "cloudru_evolution_compute_interface" "ansible_ctrl" {
  project_id = var.project_id
  name       = "${local.ansible_ctrl_name}-interface"

  zone_identifier = {
    name = var.zone
  }

  description                = "Network interface for Ansible control node"
  subnet_id                  = cloudru_evolution_compute_subnet.cloudlab.id
  
  # Required because ansible-ctrl-01 works as NAT/router for private k3s nodes.
  # If enabled, Cloud.ru blocks forwarded traffic where this VM is not the final source/destination.
  interface_security_enabled = false

  security_groups_identifiers = {
    value = [{
      id = cloudru_evolution_compute_security_group.ansible_ctrl.id
    }]
  }

  external_ip_specs = {
    new_external_ip = true
  }

  type = "INTERFACE_TYPE_REGULAR"
}

resource "cloudru_evolution_compute_vm" "ansible_ctrl" {
  project_id = var.project_id
  name       = local.ansible_ctrl_name

  zone_identifier = {
    name = var.zone
  }

  flavor_identifier = {
    name = var.ansible_ctrl_flavor
  }

  description = "Ansible control node for cloudlab"

  disk_identifiers = [{
    disk_id = cloudru_evolution_compute_disk.ansible_ctrl.id
  }]

  network_interfaces = [{
    interface_id = cloudru_evolution_compute_interface.ansible_ctrl.id
  }]

  cloud_init_userdata = base64encode(local.ansible_ctrl_cloud_init)
}