resource "google_compute_firewall" "ssh" {
  project     = "${local.project}"
  name        = "${local.name}-vpc-allow-ssh"
  network     = data.terraform_remote_state.bucket.outputs.xoxot_vpc.id
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags   = ["bastion"]
  source_ranges = ["35.235.240.0/20"]
}