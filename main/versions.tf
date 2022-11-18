provider "google" {
  region  = "asia-northeast3" #Asia Pacific (Seoul Region)
  version = "~> 4.0"
}

terraform {
  backend "gcs" {
    bucket = "xoxot-bucket-tfstate" # 사용할 버킷 이름
    prefix = "terraform/state"      # 저장되는 경로
  }
}