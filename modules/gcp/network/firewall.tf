# Create firewall rules based on the list of configurations

resource "google_compute_firewall" "firewall_rule" {
  project     = var.project
  count       = var.enable ? length(var.firewall_rules) : 0
  name        = var.firewall_rules[count.index].name
  description = var.firewall_rules[count.index].description
  direction   = var.firewall_rules[count.index].direction
  /*action        = var.firewall_rules[count.index].action*/
  source_ranges = var.firewall_rules[count.index].source_ips
  allow {
    protocol = var.firewall_rules[count.index].protocol
    ports    = var.firewall_rules[count.index].ports
  }
  network     = var.firewall_rules[count.index].network_name
  target_tags = var.firewall_destination_tags
  depends_on  = [google_compute_network.vpc_network]
}




