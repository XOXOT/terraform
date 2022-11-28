resource "google_sql_database_instance" "xoxot_db" {
  name             = "${local.name}-db"
  region           = "${local.region}"
  database_version = "MYSQL_8_0"

  settings {
    tier              = "db-f1-micro"
    availability_type = "REGIONAL"

    location_preference {
      zone           = "${local.region}-a"
      secondary_zone = "${local.region}-c"
    }

    backup_configuration {
      binary_log_enabled = true
      enabled            = true
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = data.terraform_remote_state.bucket.outputs.xoxot_vpc.id
    }
  }
  deletion_protection = false
}

resource "google_sql_user" "users" {
  name     = "xoxot"
  instance = google_sql_database_instance.xoxot_db.name
  password = "xoxot"
}

resource "google_sql_database" "xoxot_db" {
  name     = "xoxot"
  instance = google_sql_database_instance.xoxot_db.name
}