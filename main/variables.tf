######### 로컬 변수 #########
locals {
  project = "terraform-tae"
  env     = "heetae"
  stage   = "dev"
  name    = "${local.project}-${local.env}-${local.stage}"
  region  = "asia-northeast3"
}

data "google_compute_default_service_account" "default" {
}
