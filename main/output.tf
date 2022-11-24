#중요하무니다
output "xoxot_vpc" {
  value = google_compute_network.xoxot_vpc
}

output "xoxot_subnet" {
  value = google_compute_subnetwork.xoxot_subnet
}

output "cluster_id" {
  value = google_container_cluster.primary.id
}