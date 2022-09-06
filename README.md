# EnUygun_Project Documentation

This project uses Terraform to interract with Google Cloud Platform (GCP). It has been made with Terraform files (.tf) only.
Here is the file structure:
  - main.tf => Main file to connect to GCP and create the project. (credentials file is not uploaded for security precautions)
    ~ Here are the project details that created in GCP:
    ~ project = "enuygun-project"
    ~ region  = "europe-west3"
    ~ zone    = "europe-west3-c" (Located in Frankfurt, Germany, Europe)
    
  - virtual_private_cloud.tf => Virtual Private Cloud (VPC) file to create virtual private network on GCP.
    ~ Creating subnetworks automaticly is restricted (auto_create_subnetworks = "false") since subnetwork is created below of the file.
  
  - google_kubernetes_engine.tf => Google Kubernates Engine (GKE) file to create kubernetes cluster in new created VPC on GCP.
    ~ In the main file, location variable is created and it is used in GKE file as "location = var.zone"
    ~ The initial number of nodes for the pool is 1 (initial_node_count = 1).
    
  - mysql.tf => 
