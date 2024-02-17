resource "tls_private_key" "terraform_generated_private_key" {
  count = var.enable ? length(var.vm_setting.name) : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  count = var.enable ? length(var.vm_setting.name) : 0
  content         = tls_private_key.terraform_generated_private_key[count.index].private_key_pem
  filename        = "${var.vm_setting.ssh_keys_path}/${var.vm_setting.name[count.index]}-ssh_private_keys_pairs.pem"
  file_permission = "400"
}

