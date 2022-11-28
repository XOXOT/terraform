provider "google" {
  region  = "asia-northeast3" #Asia Pacific (Seoul Region)
  version = "~> 4.0"
}

data "terraform_remote_state" "bucket" {
  backend = "gcs"
  config = {
    bucket = "${local.bucket}"
    prefix = "terraform/state"
  }
}