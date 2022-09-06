# EnUygun_Project Documentation

This project uses Terraform to interract with Google Cloud Platform (GCP). It has been made with Terraform files (.tf) only.
Here is the file structure:
  - main.tf => Main file to connect to GCP and create the project. (credentials file is not uploaded for security precautions)
    ~ Here are the project details that created in GCP:
    ~ project = "enuygun-project"
    ~ region  = "europe-west3"
    ~ zone    = "europe-west3-c" (Located in Frankfurt, Germany, Europe)
    
  - virtual_private_cloud.tf => Virtual Private Cloud (VPC) file to create virtual private network.
    ~ Creating subnetworks automaticly is restricted (auto_create_subnetworks = "false") since subnetwork is created below of the file.
  
  - google_kubernetes_engine.tf => Google Kubernates Engine (GKE) file to create kubernetes cluster in new created VPC.
    ~ In the main file, location variable is created and it is used in GKE file as "location = var.zone"
    ~ The initial number of nodes for the pool is 1 (initial_node_count = 1).
    
  - mysql.tf => MySQL file to create a CloudSQL instance and a user wordpress.
    ~ Saves the password in the "password-file" (filename = "./password-file") (password-file is not uploaded for security precautions)
    
  - persistent_volume_claim.tf => Persistent Volume Claim (PVC) file to create volume for Workpress deployment.
  - service_account.tf => Service Account (SA) file to create a ServiceAccount and bind it with permission required to access CloudSQL instances.
  - secret.tf => Secret file to create a key for ServiceAccount and create Kubernetes secrets for Wordpress and CloudSQL pods.
  - deployment.tf => Deployment file to create a deployment that will run Wordpress and cloudsql-proxy.
  - expose.tf => Expose file to expose Wordpress by using "NodePort" on port 80.

After the configurations and downloaded terraform, we ran these commands:

  $ terraform init
  $ terraform plan --out plan.out
  $ terraform apply "plan.out"
  
  - The first command ($ terraform init) will display => Terraform has been successfully initialized!
  - The second command ($ terraform plan --out plan.out) will create "plan.out" file that shows which instances will be created and their details.
  - The third command ($ terraform apply "plan.out") will apply the plan.out file that we created above.
