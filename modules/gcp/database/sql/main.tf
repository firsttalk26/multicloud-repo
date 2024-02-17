resource "google_sql_database_instance" "db_instance" {
  project             = var.project
  count               = var.enable ? length(var.db_setting.name) : 0
  name                = var.db_setting.name[count.index]
  database_version    = var.db_setting.version
  region              = var.db_setting.region
  root_password       = var.db_setting.root_password
  deletion_protection = var.db_setting.deletion_protection
  settings {
    tier              = var.db_setting.machine_type
    disk_size         = var.db_setting.disk_size
    user_labels       = var.db_setting.labels
    edition           = var.db_setting.edition
    availability_type = var.db_setting.availability_type
    disk_autoresize   = var.db_setting.disk_autoresize
    disk_type         = var.db_setting.disk_type

    dynamic "database_flags" {
      for_each = var.db_setting.flags
      content {
        name  = database_flags.key
        value = database_flags.value
      }
    }

    backup_configuration {
      binary_log_enabled = true
      enabled            = true
      #point_in_time_recovery_enabled = true
      start_time                     = "00:00"
      location                       = var.db_setting.backup_location
      transaction_log_retention_days = 7
    }

    ip_configuration {
      ipv4_enabled = true
      require_ssl  = true
      #private_network = "projects/cgroove-cloud/global/networks/bsnl-prod-vnet"
      dynamic "authorized_networks" {
        for_each = var.db_setting.authorized_networks
        content {
          name = authorized_networks.key
          value = authorized_networks.value
        }
      }
    }
    maintenance_window {
      day          = 6
      hour         = 20
      update_track = "stable"
    }
    insights_config {

      query_insights_enabled  = true
      record_application_tags = true
      record_client_address   = true
    }

    password_validation_policy {
      min_length                  = 7
      reuse_interval              = var.db_setting.version == "MYSQL_5_7" ? 0 : 2
      disallow_username_substring = true
      enable_password_policy      = true
    }

  }


}


output "enable" {
  
  value = var.enable
}
