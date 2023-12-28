provider "google" {
  credentials = file("key.json")
  project     = "high-territory-403908"
  region      = "us-central1"
}

resource "google_container_cluster" "my_cluster" {
  name     = "my-cluster"
  location = "us-central1-a"

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 130  
    image_type   = "COS_CONTAINERD"
    spot = true
  }

  initial_node_count = 3
}