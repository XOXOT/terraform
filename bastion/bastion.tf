resource "google_compute_instance" "bastion_module" {
  name         = "bastion"
  machine_type = "n1-standard-1"
  zone         = "${local.region}-a"

  tags = ["bastion"]

  boot_disk {
    initialize_params {
      image = "rocky-linux-cloud/rocky-linux-8-optimized-gcp"
    }
  }

  network_interface {
    network    = data.terraform_remote_state.bucket.outputs.xoxot_vpc.id
    subnetwork = data.terraform_remote_state.bucket.outputs.xoxot_subnet.id

    access_config {
      // Ephemeral public IP
    }
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    scopes = ["userinfo-email", "compute-ro", "storage-ro", "cloud-platform", "cloud-source-repos"]
  }


  metadata_startup_script = data.template_file.startup_script.rendered
  # depends_on              = [google_container_cluster.regional]

}