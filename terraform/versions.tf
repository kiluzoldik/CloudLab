terraform {
  required_version = ">= 1.12.0"

  required_providers {
    cloudru = {
      source  = "cloud.ru/cloudru/cloud"
      version = "2.0.0"
    }
  }
}