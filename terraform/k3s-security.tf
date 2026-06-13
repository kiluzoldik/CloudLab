resource "cloudru_evolution_compute_security_group" "k3s_nodes" {
  project_id = var.project_id
  name       = "${local.name_prefix}-k3s-nodes-sg"

  zone_identifier = {
    name = var.zone
  }

  description = "Security group for k3s cluster nodes"
}

resource "cloudru_evolution_compute_security_group_rule" "k3s_ingress_ssh_from_ansible" {
  security_group_id = cloudru_evolution_compute_security_group.k3s_nodes.id

  direction        = "TRAFFIC_DIRECTION_INGRESS"
  ether_type       = "ETHER_TYPE_IPV4"
  ip_protocol      = "IP_PROTOCOL_TCP"
  port_range       = "22:22"
  description      = "SSH from Ansible control node"
  remote_ip_prefix = "${cloudru_evolution_compute_interface.ansible_ctrl.ip_address}/32"
}

resource "cloudru_evolution_compute_security_group_rule" "k3s_ingress_internal_tcp" {
  security_group_id = cloudru_evolution_compute_security_group.k3s_nodes.id

  direction        = "TRAFFIC_DIRECTION_INGRESS"
  ether_type       = "ETHER_TYPE_IPV4"
  ip_protocol      = "IP_PROTOCOL_TCP"
  port_range       = "1:65535"
  description      = "Allow internal TCP traffic inside cloudlab subnet"
  remote_ip_prefix = var.subnet_address
}

resource "cloudru_evolution_compute_security_group_rule" "k3s_ingress_internal_udp" {
  security_group_id = cloudru_evolution_compute_security_group.k3s_nodes.id

  direction        = "TRAFFIC_DIRECTION_INGRESS"
  ether_type       = "ETHER_TYPE_IPV4"
  ip_protocol      = "IP_PROTOCOL_UDP"
  port_range       = "1:65535"
  description      = "Allow internal UDP traffic inside cloudlab subnet"
  remote_ip_prefix = var.subnet_address
}

resource "cloudru_evolution_compute_security_group_rule" "k3s_egress_tcp" {
  security_group_id = cloudru_evolution_compute_security_group.k3s_nodes.id

  direction        = "TRAFFIC_DIRECTION_EGRESS"
  ether_type       = "ETHER_TYPE_IPV4"
  ip_protocol      = "IP_PROTOCOL_TCP"
  port_range       = "1:65535"
  description      = "Allow outbound TCP"
  remote_ip_prefix = "0.0.0.0/0"
}

resource "cloudru_evolution_compute_security_group_rule" "k3s_egress_udp" {
  security_group_id = cloudru_evolution_compute_security_group.k3s_nodes.id

  direction        = "TRAFFIC_DIRECTION_EGRESS"
  ether_type       = "ETHER_TYPE_IPV4"
  ip_protocol      = "IP_PROTOCOL_UDP"
  port_range       = "1:65535"
  description      = "Allow outbound UDP"
  remote_ip_prefix = "0.0.0.0/0"
}