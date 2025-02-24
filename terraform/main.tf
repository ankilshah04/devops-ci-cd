terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 2.0"  # You can specify the version you want to use
    }
    local = {
      source = "hashicorp/local"
      version = "~> 2.0"  # You can specify the version as needed
    }
  }
}

# Provider block for local provider
provider "local" {}

# Provider block for Docker
provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Create a local file
resource "local_file" "example_file" {
  content  = "Terraform is managing my local file."
  filename = "/Users/ankilshah/GitHub-Repo/devops-ci-cd/terraform/local_deployment.txt"
}

# Run a Docker container (e.g., Nginx)
resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx_container" {
  name  = "nginx-container"
  image = docker_image.nginx.latest
  ports {
    internal = 80
    external = 8080
  }
}

# Outputs
output "file_created" {
  value = local_file.example_file.filename
}

output "nginx_container_ip" {
  value = docker_container.nginx_container.ip_address
}
