resource "google_redis_instance" "redis_cache" {
  project                 = var.project
  count                   = var.enable ? length(var.redis_setting.name) : 0
  name                    = var.redis_setting.name[count.index]
  memory_size_gb          = var.redis_setting.memory_size[count.index]
  region                  = var.redis_setting.location[count.index]
  tier                    = var.redis_setting.tier[count.index]
  transit_encryption_mode = "SERVER_AUTHENTICATION"
  redis_version           = "REDIS_6_X"
  replica_count           = var.redis_setting.replica_count[count.index]
  read_replicas_mode      = var.redis_setting.read_replicas_mode[count.index]
  alternative_location_id = var.redis_setting.tier == "STANDARD_HA" ? "asia-south1-b" : ""
  auth_enabled            = true
  authorized_network      = var.redis_setting.network[count.index]
  connect_mode            = "DIRECT_PEERING"
  labels                  = var.redis_setting.labels
  location_id             = "asia-south1-a"

  persistence_config {
    persistence_mode = "DISABLED"
  }


  maintenance_policy {
    weekly_maintenance_window {
      day = "SUNDAY"
      start_time {
        hours   = 20
        minutes = 00
        seconds = 00
      }
    }
  }

}



output "id" {
  value = resource.google_redis_instance.redis_cache.*.id
}


output "auth_string" {
  value = resource.google_redis_instance.redis_cache.*.auth_string
}

output "redis_host" {
  value = resource.google_redis_instance.redis_cache.*.host
}

output "redis_port" {
  value = resource.google_redis_instance.redis_cache.*.port
}


output "enable" {
  
  value = var.enable
}
