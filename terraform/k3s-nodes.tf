locals {
  k3s_nodes = {
    master = {
      name       = local.k3s_master_name
      cloud_init = local.k3s_master_cloud_init
    }

    worker_01 = {
      name       = local.k3s_worker_01
      cloud_init = local.k3s_worker_01_cloud_init
    }

    worker_02 = {
      name       = local.k3s_worker_02
      cloud_init = local.k3s_worker_02_cloud_init
    }
  }
}

resource "cloudru_evolution_compute_disk" "k3s" {
  for_each = local.k3s_nodes

  project_id = var.project_id
  name       = "${each.value.name}-disk"
  size       = var.k3s_node_disk_size

  zone_identifier = {
    name = var.zone
  }

  disk_type_identifier = {
    name = var.disk_type
  }

  description = "Boot disk for ${each.value.name}"
  bootable    = true
  image_id    = local.ubuntu_image_id

  encrypted = false
  readonly  = false
  shared    = false
}

resource "cloudru_evolution_compute_interface" "k3s" {
  for_each = local.k3s_nodes

  project_id = var.project_id
  name       = "${each.value.name}-interface"

  zone_identifier = {
    name = var.zone
  }

  description                = "Network interface for ${each.value.name}"
  subnet_id                  = cloudru_evolution_compute_subnet.cloudlab.id
  interface_security_enabled = true

  security_groups_identifiers = {
    value = [{
      id = cloudru_evolution_compute_security_group.k3s_nodes.id
    }]
  }

  type = "INTERFACE_TYPE_REGULAR"
}

resource "cloudru_evolution_compute_vm" "k3s" {
  for_each = local.k3s_nodes

  project_id = var.project_id
  name       = each.value.name

  zone_identifier = {
    name = var.zone
  }

  flavor_identifier = {
    name = var.k3s_node_flavor
  }

  description = "k3s node ${each.key}"

  disk_identifiers = [{
    disk_id = cloudru_evolution_compute_disk.k3s[each.key].id
  }]

  network_interfaces = [{
    interface_id = cloudru_evolution_compute_interface.k3s[each.key].id
  }]

  cloud_init_userdata = base64encode(each.value.cloud_init)
}