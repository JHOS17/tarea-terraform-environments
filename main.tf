terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

provider "docker" {}

# Redes de Docker
resource "docker_network" "dev_network" {
  name = "red-dev"
}

resource "docker_network" "qa_network" {
  name = "red-qa"
}

# Imágenes
resource "docker_image" "nginx" {
  name = "nginx:alpine"
}

resource "docker_image" "node" {
  name = "node:18-alpine"
}

resource "docker_image" "postgres" {
  name = "postgres:15-alpine"
}

# --- ENTORNO DEV ---
resource "docker_container" "bd_dev" {
  name  = "bd-dev"
  image = docker_image.postgres.image_id
  env = [
    "POSTGRES_PASSWORD=secret",
    "POSTGRES_DB=devdb"
  ]
  networks_advanced {
    name = docker_network.dev_network.name
  }
  ports {
    internal = 5432
    external = 4003
  }
}

resource "docker_container" "api_dev" {
  name  = "api-dev"
  image = docker_image.node.image_id
  networks_advanced {
    name = docker_network.dev_network.name
  }
  ports {
    internal = 3000
    external = 4002
  }
}

resource "docker_container" "web_dev" {
  name  = "web-dev"
  image = docker_image.nginx.image_id
  networks_advanced {
    name = docker_network.dev_network.name
  }
  ports {
    internal = 80
    external = 4001
  }
}

# --- ENTORNO QA ---
resource "docker_container" "bd_qa" {
  name  = "bd-qa"
  image = docker_image.postgres.image_id
  env = [
    "POSTGRES_PASSWORD=secret",
    "POSTGRES_DB=qadb"
  ]
  networks_advanced {
    name = docker_network.qa_network.name
  }
  ports {
    internal = 5432
    external = 5003
  }
}

resource "docker_container" "api_qa" {
  name  = "api-qa"
  image = docker_image.node.image_id
  networks_advanced {
    name = docker_network.qa_network.name
  }
  ports {
    internal = 3000
    external = 5002
  }
}

resource "docker_container" "web_qa" {
  name  = "web-qa"
  image = docker_image.nginx.image_id
  networks_advanced {
    name = docker_network.qa_network.name
  }
  ports {
    internal = 80
    external = 5001
  }
}
