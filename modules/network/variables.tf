variable "project_region" {
  type        = string
  default     = "europe-west9"
  description = "The region of your project"
}

variable "network" {}
variable "subnetwork" {}
variable "project_name" {}
variable "gke_service_account" {}
variable "ip_range_services" {}
variable "ip_range_pods" {}
  
