data "cloudru_evolution_compute_image_collection" "ubuntu" {
  project_id = var.project_id
  page_size  = 100
}

locals {
  ubuntu_image_id = [
    for img in data.cloudru_evolution_compute_image_collection.ubuntu.images : img.id
    if img.name == var.ubuntu_image_name
  ][0]
}