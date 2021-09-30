#terraform docker integration
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nodered_image" {
    name = "nodered/node-red:latest"
}

resource "random_string" "random" {
  count = 2
  length = 4
  special = false
  upper = false
}



resource "docker_container" "nodered_container" {
  count = 2  
  name = join("-",["nodered", random_string.random[count.index].result])
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    #external = 1880
    }
}

output "IP-Adress" {
  value = join(":", [docker_conteiner.nodered_container[0].ip_adress, docker_container.nodered_conteiner[0].ports[0].external])
  description = "TheIP adress of the container"
}

uotput "container-name" {
  value = docker_container.nodered_container[0].name
  description = "The name of the container"
}      

output "IP-Adress" {
  value = join(":", [docker_conteiner.nodered_container[1].ip_adress, docker_container.nodered_conteiner[1].ports[0].external])
  description = "TheIP adress of the container"
}

uotput "container-name" {
  value = docker_container.nodered_container[1].name
  description = "The name of the container"  
}
