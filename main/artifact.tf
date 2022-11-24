# resource "google_artifact_registry_repository" "xoxot-repository" {
#   location      = "${local.region}"
#   repository_id = "eb-repository"
#   description   = "was artifact repository"
#   format        = "DOCKER"
# }

# resource "google_artifact_registry_repository" "xoxot-repository" {
#   location      = "${local.region}"
#   repository_id = "web-repository"
#   description   = "web artifact repository"
#   format        = "DOCKER"
# }