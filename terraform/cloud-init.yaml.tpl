#cloud-config
hostname: ${hostname}
manage_etc_hosts: true

users:
  - name: ${username}
    groups: sudo
    shell: /bin/bash
    sudo: ALL=(ALL) NOPASSWD:ALL
    lock_passwd: true
    ssh_authorized_keys:
      - ${ssh_public_key}

package_update: true
package_upgrade: false

packages:
  - curl
  - wget
  - git
  - vim
  - htop
  - ca-certificates
  - gnupg
  - lsb-release
  - openssh-server
  - python3

runcmd:
  - systemctl enable ssh
  - systemctl start ssh