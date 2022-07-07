data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                 = "${var.project_name}"
  name                       = "${var.project_name}-gke-1"
  region                     = "${var.project_region}"
  zones                      = ["${var.project_region}-a", "${var.project_region}-b"]
  network                    = "${var.network}"
  subnetwork                 = "${var.subnetwork}"
  ip_range_pods              = "${var.ip_range_pods}"
  ip_range_services          = "${var.ip_range_services}"
  http_load_balancing        = true
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  enable_private_endpoint = false
  enable_private_nodes    = true
  master_ipv4_cidr_block = "172.16.0.32/28"
  node_pools = [
    {
      name                      = "default-node-pool"
      machine_type              = "e2-medium"
      node_locations            = "${var.project_region}-a,${var.project_region}-b"
      min_count                 = 1
      max_count                 = 2
      local_ssd_count           = 0
      disk_size_gb              = 100
      disk_type                 = "pd-standard"
      image_type                = "COS_CONTAINERD"
      enable_gcfs               = false
      auto_repair               = true
      auto_upgrade              = true
      
      service_account           = "${var.gke_service_account}"
      preemptible               = false
      initial_node_count        = 2
    },
  ]

  node_pools_oauth_scopes = {
    all = []

    default-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}
