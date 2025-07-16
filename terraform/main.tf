provider "docker" {
    host = "unix://var/run/docker.sock"
}

resource "docker_image" "ubuntu" {
    name = "local-ubuntu-ssh"
    build {
        context = "../"
        dockerfile = "Dockerfile"
        }
}

resource "docker_container" "webserver" {
    name = "webserver"
    image = docker_image.ubuntu.latest
    ports {
        internal = 22
        external = 2222
        }

    provisioner "local-exec" {
        command = "echo '[web]\nlocalhost ansible_ports=2222 ansible_host=127.0.0.1 ansible_user=root ansible_password=root ansible_connection=ssh' > ../ansible/inventory.ini"
        }
    }