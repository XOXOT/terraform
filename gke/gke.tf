# # # #GKE cluster
# # # resource "google_container_cluster" "primary" {
# # #   name     = "${local.project}-gke"
# # #   location = "${local.region}"
 
# # #   network    = google_compute_network.gogle_vpc.name
# # #   subnetwork = google_compute_subnetwork.gogle_subnet.name
 
# # # # Enabling Autopilot for this cluster
# # #   enable_autopilot = false
# # # }

# resource "google_container_cluster" "regional" {
#   name   = "${local.project}-gke"
#   location = "${local.region}"
#   initial_node_count = "1"
#   remove_default_node_pool = "true"

#   ip_allocation_policy {

#   }

#   network    = data.terraform_remote_state.bucket.outputs.xoxot_vpc.id
#   subnetwork = data.terraform_remote_state.bucket.outputs.xoxot_subnet.id
# }

# resource "google_container_node_pool" "regional-np" {
#   name       = "${local.project}-pool"
#   location     = "${local.region}"
#   cluster    = "${google_container_cluster.regional.name}"
#   node_count = 1
#   depends_on = ["google_container_cluster.regional"]
# }