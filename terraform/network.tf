resource "cloudru_evolution_compute_subnet" "cloudlab" {
  project_id = var.project_id
  name       = "${local.name_prefix}-subnet"

  zone_identifier = {
    name = var.zone
  }

  description    = "Subnet for cloudlab VMs"
  subnet_address = var.subnet_address
  routed_network = true
  default        = false
  vpc_id         = var.vpc_id

  dns_servers = {
    value = ["8.8.8.8"]
  }
}

resource "cloudru_evolution_compute_security_group" "ansible_ctrl" {
  project_id = var.project_id
  name       = "${local.name_prefix}-ansible-ctrl-sg"

  zone_identifier = {
    name = var.zone
  }

  description = "Security group for Ansible control node"
}

resource "cloudru_evolution_compute_security_group_rule" "ansible_ctrl_ingress_ssh" {
  security_group_id = cloudru_evolution_compute_security_group.ansible_ctrl.id

  direction        = "TRAFFIC_DIRECTION_INGRESS"
  ether_type       = "ETHER_TYPE_IPV4"
  ip_protocol      = "IP_PROTOCOL_TCP"
  port_range       = "22:22"
  description      = "SSH from my public IP"
  remote_ip_prefix = var.my_ip_cidr
}

resource "cloudru_evolution_compute_security_group_rule" "ansible_ctrl_egress_tcp" {
  security_group_id = cloudru_evolution_compute_security_group.ansible_ctrl.id

  direction        = "TRAFFIC_DIRECTION_EGRESS"
  ether_type       = "ETHER_TYPE_IPV4"
  ip_protocol      = "IP_PROTOCOL_TCP"
  port_range       = "1:65535"
  description      = "Allow outbound TCP"
  remote_ip_prefix = "0.0.0.0/0"
}

resource "cloudru_evolution_compute_security_group_rule" "ansible_ctrl_egress_udp" {
  security_group_id = cloudru_evolution_compute_security_group.ansible_ctrl.id

  direction        = "TRAFFIC_DIRECTION_EGRESS"
  ether_type       = "ETHER_TYPE_IPV4"
  ip_protocol      = "IP_PROTOCOL_UDP"
  port_range       = "1:65535"
  description      = "Allow outbound UDP"
  remote_ip_prefix = "0.0.0.0/0"
}

resource "cloudru_evolution_compute_security_group_rule" "ansible_ctrl_ingress_nat_tcp" {
  security_group_id = cloudru_evolution_compute_security_group.ansible_ctrl.id

  direction        = "TRAFFIC_DIRECTION_INGRESS"
  ether_type       = "ETHER_TYPE_IPV4"
  ip_protocol      = "IP_PROTOCOL_TCP"
  port_range       = "1:65535"
  description      = "Allow NAT TCP traffic from cloudlab subnet"
  remote_ip_prefix = var.subnet_address
}

resource "cloudru_evolution_compute_security_group_rule" "ansible_ctrl_ingress_nat_udp" {
  security_group_id = cloudru_evolution_compute_security_group.ansible_ctrl.id

  direction        = "TRAFFIC_DIRECTION_INGRESS"
  ether_type       = "ETHER_TYPE_IPV4"
  ip_protocol      = "IP_PROTOCOL_UDP"
  port_range       = "1:65535"
  description      = "Allow NAT UDP traffic from cloudlab subnet"
  remote_ip_prefix = var.subnet_address
}