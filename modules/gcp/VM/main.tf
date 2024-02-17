
resource "google_compute_instance" "vm_instance" {
  count               = var.enable ? length(var.vm_setting.name) : 0
  name                = var.vm_setting.name[count.index]
  machine_type        = var.vm_setting.machine_type[count.index]
  zone                = var.vm_setting.zone[count.index]
  deletion_protection = var.vm_setting.deletion_protection
  labels              = var.vm_setting.labels

  boot_disk {
    initialize_params {
      image  = var.vm_setting.image_name[count.index]
      size   = var.vm_setting.boot_disk_size
      type   = var.vm_setting.boot_disk_type
      labels = var.vm_setting.labels
    }
  }

  network_interface {
    network    = var.vm_setting.network[count.index]
    subnetwork = var.vm_setting.subnetwork[count.index]
    /*subnetwork_project    = var.SUBNETWORK_PROJECT*/

    access_config {
      nat_ip = google_compute_address.external-ip[count.index].address
    }
  }

  allow_stopping_for_update = var.vm_setting.allow_stopping_for_update
  /*
  attached_disk{
    source = "${var.vm_setting.name[count.index]}-data-disk"
    device_name = "/dev/sdc"
    mode = "READ_WRITE"

  }
  */

  can_ip_forward = false

  #description= "This resource is created for dev env"
  #hostname = var.vm_setting.name[count.index]
  tags                    = var.vm_setting.tags
  metadata_startup_script = "echo This vm is created using terraform IaaC > /info"
  metadata = {
    #ssh-keys = join("\n", [for key in var.vm_setting.ssh-keys : "urvaadmin:${key}"])
    ssh-keys  = "admin:${tls_private_key.terraform_generated_private_key[count.index].public_key_openssh}"
  }
  
  connection {
    type     = "ssh"
    user     = "admin"
    private_key = "${tls_private_key.terraform_generated_private_key[count.index].private_key_pem}"
    host     = google_compute_address.external-ip[count.index].address
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'connected...........................'",
      "sudo yum update -y",
      "sudo curl -fsSL https://rpm.nodesource.com/setup_16.x | sudo -E bash - ",
      "sudo yum install nodejs  -y"

      ]
  }

  depends_on = [google_compute_address.external-ip]

}

/**
output "network_tags" {
  
  value = var.vm_setting.tags
}
**/

resource "google_compute_address" "external-ip" {
  count        = var.enable == true ? length(var.vm_setting.name) : 0
  name         = "${var.vm_setting.name[count.index]}-public-ip"
  address_type = "EXTERNAL"
}



output "enable" {
  
  value = var.enable
}

