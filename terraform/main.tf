terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

resource "yandex_compute_instance" "gitlab" {
  name = "gitlab"

  resources {
    cores  = 2
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = 40
    }
  }

  network_interface {
    # Указан id подсети default-ru-central1-a
    subnet_id = var.subnet_id
    nat       = true
  }
  
    metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  connection {
    type        = "ssh"
    host        = self.network_interface.0.nat_ip_address
    user        = "ubuntu"
    agent       = false
    private_key = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    script = "files/install_docker.sh"
  }
 
   provisioner "file" {
    source      = "files/docker-compose.yml"
    destination = "/tmp/docker-compose.yml"
  }
  
  provisioner "remote-exec" {
    inline = [
      "sed -i 's/IPADDRESS/${yandex_compute_instance.gitlab.network_interface.0.nat_ip_address}/g' /tmp/docker-compose.yml"
    ]
  }
  
    provisioner "remote-exec" {
    script = "files/install_gitlab.sh"
  }
  
}
