provider "google" {
  credentials = file("key.json") #key for auth in google account
  project     = "high-territory-403908" #my id project
  region      = "us-central1" #custom region 
}

resource "google_container_cluster" "my_cluster" {
  name     = "my-cluster"
  location = "us-central1-a" #our region + letter (a.b.c) 

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 130  
    image_type   = "COS_CONTAINERD"
    spot = true
  }

  initial_node_count = 3
}
