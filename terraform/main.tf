terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

provider "docker" {
  host        = "ssh://student@111.88.162.73:22"
  ssh_opts    = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]

}

resource "docker_network" "custom_nginx_net" {
  name = "nginx_dedicated_net"
}

resource "docker_volume" "nginx_volume" {
  name = "nginx_data_volume"
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx_custom" {
  name  = "nginx_custom_port"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8080
  }

  networks_advanced {
    name = docker_network.custom_nginx_net.name
  }

  volumes {
    volume_name    = docker_volume.nginx_volume.name
    container_path = "/usr/share/nginx/html"
  }
}