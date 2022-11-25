# NODE - Services
resource "google_container_node_pool" "service_nodes" {
  provider           = google-beta
  name               = "service-pool"
  cluster            = data.terraform_remote_state.bucket.outputs.cluster_id
  initial_node_count = 1

  node_locations = ["asia-northeast3-b", "asia-northeast3-c"]

  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    # service_account = "gke-access-account@eunoia0523.iam.gserviceaccount.com"
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  network_config {
    create_pod_range    = true
    pod_ipv4_cidr_block = "10.42.0.0/16"
    pod_range           = "service-pod-range"
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
  autoscaling {
    min_node_count = 2
    max_node_count = 8
  }
}

# Node - CI/CD
resource "google_container_node_pool" "cicd_nodes" {
  provider           = google-beta  #provider google-beta로 해줘야 nodepool network 구성 가능
  name               = "cicd-pool"
  cluster            = data.terraform_remote_state.bucket.outputs.cluster_id
  initial_node_count = 1

  node_locations = ["asia-northeast3-a"]

  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    # service_account = "gke-access-account@eunoia0523.iam.gserviceaccount.com"
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  network_config {
    create_pod_range    = true
    pod_ipv4_cidr_block = "10.32.0.0/16"
    pod_range           = "cicd-pod-range"
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}