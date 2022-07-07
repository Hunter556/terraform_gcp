

# First Private subnet
resource "google_compute_subnetwork" "private_subnet_1" {
  network                  = google_compute_network.vpc.id
  ip_cidr_range            = "10.5.0.0/20"
  private_ip_google_access = true
  region                   = var.project_region
  name                     = "${var.project_name}-${var.project_environnement}-private-subnet-1"
  secondary_ip_range = [{
    range_name    = "${var.project_name}-${var.project_environnement}-private-subnet-1-gke-01-pods"
    ip_cidr_range = "10.0.0.0/14"
  },
  {
    range_name    = "${var.project_name}-${var.project_environnement}-private-subnet-1-gke-01-services"
    ip_cidr_range = "10.4.0.0/19"
  }
  
   ]

}


#route table 
resource "google_compute_route" "route_table_private_1" {
  name             = "route-table-private-1"
  dest_range       = "0.0.0.0/0"
  network          = google_compute_network.vpc.id
  next_hop_gateway = "default-internet-gateway"
  priority         = 100
  depends_on = [
    google_compute_subnetwork.private_subnet_1
  ]
}


resource "google_compute_network" "vpc" {
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
  name                            = "${var.vpc_name}"
}


resource "google_compute_router" "router_subnet" {
  name    = "router-vpc-nat"
  network = google_compute_network.vpc.id
  region  = var.project_region
}



resource "google_compute_router_nat" "nat_gateway" {
  name                               = "nat-gateway"
  router                             = google_compute_router.router_subnet.name
  region                             = google_compute_router.router_subnet.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

}

