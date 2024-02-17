
resource "google_storage_bucket" "bucket_storage" {
  project       = var.project
  count         = var.enable ? 1 : 0
  name          = "${var.bucket_setting.name}-${random_id.random[count.index].hex}"
  location      = var.bucket_setting.location
  force_destroy = false
  autoclass {
    enabled = true
  }

  versioning {
    enabled = var.bucket_setting.versioning
  }
  labels                   = var.bucket_setting.labels
  public_access_prevention = var.bucket_setting.public_access
}


resource "random_id" "random" {
  count         = var.enable ? 1 : 0
  byte_length = 8
}


output "enable" {
  
  value = var.enable
}
