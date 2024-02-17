resource "google_compute_network" "vpc_network" {
  count                   = var.enable ? length(var.vpc_setting.name) : 0
  name                    = var.vpc_setting.name[count.index]
  project                 = var.project
  auto_create_subnetworks = var.vpc_setting.auto_create_subnetworks
  mtu                     = var.vpc_setting.network_mtu
  routing_mode            = var.vpc_setting.network_routing_mode

}


resource "google_compute_subnetwork" "subnet" {
  count                    = var.enable ? length(var.subnet_setting.name) : 0
  name                     = var.subnet_setting.name[count.index]
  ip_cidr_range            = var.subnet_setting.ip_cidr_range
  region                   = var.subnet_setting.region
  network                  = google_compute_network.vpc_network[count.index].id
  private_ip_google_access = var.subnet_setting.private_ip_google_access
  stack_type               = var.subnet_setting.subnet_ip_family
  depends_on               = [google_compute_network.vpc_network]
}


output "enable" {
  
  value = var.enable
}
