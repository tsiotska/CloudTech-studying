terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.16.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_network" "private_network" {
  name       = "terra-network"
  attachable = true
}

resource "docker_image" "nginx" {
  name         = "vitaliytsisaruk/cloud-tech_nginx"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.name
  name  = "nginx"
  volumes {
    container_path = "/ssl"
    host_path      = "/etc/nginx/ssl"
  }
  ports {
    internal = 80
    external = 80
  }
  ports {
    internal = 443
    external = 443
  }
  networks_advanced {
    name = "${docker_network.private_network.name}"
  }
  depends_on = [docker_container.node]
}


resource "docker_image" "node" {
  name         = "vitaliytsisaruk/cloud-tech_node"
  keep_locally = false
}

resource "docker_container" "node" {
  image = docker_image.node.name
  name  = "node"
  ports {
    internal = 3000
    external = 3000
  }
  networks_advanced {
    name = "${docker_network.private_network.name}"
  }
  depends_on = [docker_container.mongo]
}


resource "docker_image" "mongo" {
  name         = "mongo:5.0"
  keep_locally = false
}

resource "docker_container" "mongo" {
  image = docker_image.mongo.name
  name  = "mongo"
  env   = [
    "MONGO_INITDB_ROOT_USERNAME=root",
    "MONGO_INITDB_ROOT_PASSWORD=1111",
    "MONGO_INITDB_DATABASE=users"
  ]
  volumes {
    container_path = "/data/db"
    host_path      = "/data/db"
  }
  volumes {
    container_path = "/docker-entrypoint-initdb.d/mongo-init.js"
    host_path      = "/home/vitalik/Desktop/cloud-tech/mongo-init.js"
  }
  ports {
    internal = 27017
    external = 27017
  }
  networks_advanced {
    name = "${docker_network.private_network.name}"
  }
}

