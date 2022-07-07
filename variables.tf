variable "project_name" {
  type = string

}



variable "credentiels_name" {
  type = string
  
}


variable "project_region" {
  type        = string

}

variable "gke_service_account" {
  type = string
}

variable "vpc_name" {
  type = string
  
}


variable "repo_location" {
  type = string
}

variable "repo_id" {}


#service_account           = "493869906278-compute@developer.gserviceaccount.com" # clea
#service_account           = "485072204838-compute@developer.gserviceaccount.com"  # personal

#default = "premi0174285-clea"
#default = "test-757ec"

#default     = "europe-west9"
#description = "The region of your project"