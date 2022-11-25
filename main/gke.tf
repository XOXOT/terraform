resource "google_container_cluster" "primary" {
  name                     = "${local.project}-gke"
  location                 = "${local.region}"
  remove_default_node_pool = true
  initial_node_count       = 1

  ip_allocation_policy {
  }

  network    = data.terraform_remote_state.bucket.outputs.xoxot_vpc.name
  subnetwork = data.terraform_remote_state.bucket.outputs.xoxot_subnet.name

# ##이건 노드풀을 오토스케일링 하는 것임
#   cluster_autoscaling { 
#     enabled = true
#     resource_limits {
#       resource_type = "cpu" 
#       maximum = "500"
#     }
#     resource_limits {
#       resource_type = "memory"
#       maximum = "500"
#     }
#   }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "192.168.0.0/28"
  }
}