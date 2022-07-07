resource "google_artifact_registry_repository" "repo" {
  provider = google-beta

  location = var.repo_location
  repository_id = var.repo_id
  format = "DOCKER"
}
