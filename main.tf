
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }

}

provider "google" {
  credentials = "${var.credentiels_name}"
  project     = "${var.project_name}"
}

provider "google-beta" {
  credentials = "${var.credentiels_name}"
  project     = "${var.project_name}"
}




module "network" {
  project_name = "${var.project_name}"
  vpc_name = "${var.vpc_name}"
  project_region = "${var.project_region}"
  source = "./modules/network"
}


module "gke" {
  source = "./modules/gke"
  
  
  project_name = "${var.project_name}"
  gke_service_account = "${var.gke_service_account}"
  network = module.network.vpc_name
  subnetwork = module.network.subnet_name
  ip_range_pods = module.network.ip_range_pods
  ip_range_services = module.network.ip_range_services


}

module "ar" {
  source = "./modules/ar"
  
  
  repo_location = var.repo_location
  repo_id = var.repo_id



}