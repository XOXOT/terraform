resource "google_compute_network" "xoxot_vpc" {
  project                 = "${local.project}"
  name                    = "${local.name}-vpc"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "xoxot_subnet" {
  name          = "gogle-subnet"
  ip_cidr_range = "10.0.0.0/16"
  region        = "${local.region}"
  network       = google_compute_network.xoxot_vpc.id
}

#중요하무니다
output "xoxot_vpc" {
  value = google_compute_network.xoxot_vpc
}

output "xoxot_subnet" {
  value = google_compute_subnetwork.xoxot_subnet
}