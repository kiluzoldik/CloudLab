data "cloudru_evolution_compute_image_collection" "ubuntu" {
  project_id = var.project_id
  page_size  = 100
}