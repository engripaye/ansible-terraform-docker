terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.25.0"
    }
  }
}

provider "docker" {
  # Windows Docker Engine
  host = "npipe:////./pipe/docker_engine"  # <-- use this on Windows

}

resource "docker_image" "ubuntu" {
  name = "local-ubuntu-ssh"
  build {
    context    = "../"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "webserver" {
  name  = "webserver"
  image = docker_image.ubuntu.image_id

  ports {
    internal = 22
    external = 2222
  }

  provisioner "local-exec" {
    command = <<EOT
echo "[web]
localhost ansible_port=2222 ansible_host=127.0.0.1 ansible_user=root ansible_password=root ansible_connection=ssh" > ../ansible/inventory.ini
EOT
  }
}
