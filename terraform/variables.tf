variable "project_name" {
  description = "Name of the homelab project"
  type        = string
  default     = "cloudlab"
}

variable "project_id" {
  description = "Cloud.ru Evolution project ID"
  type        = string
}

variable "auth_key_id" {
  description = "Cloud.ru service account Key ID"
  type        = string
  sensitive   = true
}

variable "auth_secret" {
  description = "Cloud.ru service account Key Secret"
  type        = string
  sensitive   = true
}

variable "ansible_ctrl_vm_user" {
  description = "Linux пользователь для ВМ Ansible"
  type        = string
  default     = "ansible"
}

variable "ssh_public_key_path" {
  description = "Путь до публичного SSH ключа"
  type        = string
}

variable "vpc_id" {
  description = "Cloud.ru Evolution VPC ID"
  type        = string
}

variable "my_ip_cidr" {
  description = "Your public IP address in CIDR format for SSH access, for example 1.2.3.4/32"
  type        = string
}

variable "subnet_address" {
  description = "CIDR address for homelab subnet"
  type        = string
  default     = "10.10.0.0/24"
}

variable "zone" {
  description = "Cloud.ru availability zone"
  type        = string
  default     = "ru.AZ-1"
}

variable "ansible_ctrl_flavor" {
  description = "Flavor for Ansible control node"
  type        = string
  default     = "gen-1-1"
}

variable "ansible_ctrl_disk_size" {
  description = "Disk size for Ansible control node in GB"
  type        = number
  default     = 20
}

variable "disk_type" {
  description = "Disk type"
  type        = string
  default     = "SSD"
}