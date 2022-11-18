# provider "google" {
#   region  = "asia-northeast3" #Asia Pacific (Seoul Region)
#   version = "~> 4.0"
# }

data "terraform_remote_state" "bucket" {
  backend = "gcs"
  config = {
    bucket = "${local.bucket}"
    prefix = "terraform/state"
  }
}

terraform {
  required_version = ">=1.0.0 , <2.0.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.3.0"
    }
  }
}

provider "google" {
  region = "asia-northeast3" #Asia Pacific (Seoul Region)
}