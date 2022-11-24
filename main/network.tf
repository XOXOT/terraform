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

resource "google_compute_router" "router" {
  name    = "xoxot-router"
  region  = "${local.region}"
  network = google_compute_network.xoxot_vpc.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "xoxot-router-nat"
  router                             = google_compute_router.router.name
  region                             = "${local.region}"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}