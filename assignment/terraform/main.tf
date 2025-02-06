provider "google" {
  project     = "clear-tape-450019-u6"
  credentials = file("path/gcp_service_account_key.json")
  region      = "asia-south1"
}

resource "google_container_cluster" "gke" {
    name = "gke-cluster"
    location = "asia-south1-a"
   
    node_pool {
      name = "node-pool"
      node_count = 1
      node_config {
        machine_type = "e2-standard-8"
      }
    }
       

    deletion_protection = false

}
