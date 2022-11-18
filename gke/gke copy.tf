# resource "google_service_account" "default" {
#   account_id   = "service-account-id"
#   display_name = "Service Account"
# }


# resource "google_container_cluster" "primary" {
#   name                     = "${local.project}-gke"
#   location                 = "${local.region}"
#   remove_default_node_pool = true
#   initial_node_count       = 1

#   ip_allocation_policy {
#   }

#   network    = data.terraform_remote_state.bucket.outputs.xoxot_vpc.name
#   subnetwork = data.terraform_remote_state.bucket.outputs.xoxot_subnet.name

#   # Enabling Autopilot for this cluster
#   # enable_autopilot = true

#   node_config {
#     # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
#     service_account = google_service_account.default.email
#     oauth_scopes = ["cloud-platform"]
#   }

#   private_cluster_config {
#     enable_private_nodes    = true
#     enable_private_endpoint = false
#     master_ipv4_cidr_block  = "192.168.0.0/28"
#     /*
#     master_global_access_config {
#         enabled = true
#     }
#     */
#   }
# }

# resource "google_container_node_pool" "primary_preemptible_nodes" {
#   name       = "google-node-pool"
#   cluster    = google_container_cluster.primary.id
#   node_count = 1

#   node_config {
#     machine_type = "e2-medium"

#     # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
#     # service_account = google_service_account.default.email
#     oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
#   }

#   management {
#     auto_repair  = true
#     auto_upgrade = false
#   }
# }

resource "google_container_cluster" "primary" {
  name                     = "${local.project}-gke"
  location                 = "${local.region}"
  remove_default_node_pool = true
  initial_node_count       = 1

  ip_allocation_policy {
  }

  network    = data.terraform_remote_state.bucket.outputs.xoxot_vpc.name
  subnetwork = data.terraform_remote_state.bucket.outputs.xoxot_subnet.name

  node_config {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = "931691412530-compute@developer.gserviceaccount.com"
    oauth_scopes = ["cloud-platform"]
  }

  cluster_autoscaling { 
    enabled = true
    resource_limits {
      resource_type = "cpu" 
      maximum = "500"
    }
    resource_limits {
      resource_type = "memory"
      maximum = "500"
    }
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "192.168.0.0/28"
  }
}

resource "google_container_node_pool" "service_nodes" {
  name       = "service-pool"
  cluster    = google_container_cluster.primary.id
  initial_node_count = 1

  node_locations = ["asia-northeast3-b", "asia-northeast3-c"]

  node_config {
    machine_type = "e2-medium"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = "931691412530-compute@developer.gserviceaccount.com"
    oauth_scopes = ["cloud-platform"]
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}

resource "google_container_node_pool" "cicd_nodes" {
  name       = "cicd-pool"
  cluster    = google_container_cluster.primary.id
  initial_node_count = 1

  node_locations = ["asia-northeast3-a"]

  node_config {
    machine_type = "n1-standard-1"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = "931691412530-compute@developer.gserviceaccount.com"
    oauth_scopes = ["cloud-platform"]
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}