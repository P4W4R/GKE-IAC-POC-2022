#provider
provider "google" {
  # version     = "2.7.0"
  credentials = file(var.credentials)
  project     = var.project
  region      = var.region
}

#variables
variable "project" {
  default = "playground-s-11-db06c9f0"
}

variable "region" {
  default = "us-east1"
}

variable "zone" {
  default = "us-east1-d"
}

variable "cluster" {
  default = "poc-cluster"
}

variable "credentials" {
  default = "key.json"
}

variable "kubernetes_min_ver" {
  default = "latest"
}

variable "kubernetes_max_ver" {
  default = "latest"
}

variable "machine_type" {
  default = "g1-small"
}

variable "app_name" {
  default = "poc-app22"
}

#main
terraform {
  required_version = "1.1.8"
  backend "remote" {
    organization = "gke-poc-org-22"
    workspaces {
      name = "gke-poc-workspace"
    }
  }
}

resource "google_container_cluster" "primary" {
  name               = var.cluster
  location           = var.zone
  initial_node_count = 3

  node_config {
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }

    labels = {
      app = var.app_name
    }

    tags = ["app", var.app_name]
  }

  timeouts {
    create = "30m"
    update = "40m"
  }
}
