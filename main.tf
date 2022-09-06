provider "google" {
  credentials = file("enuygun-project-de0e34ed2334.json")
  
  project = "enuygun-project"
  region  = "europe-west3"
  zone    = "europe-west3-c"
}

variable project {
  type = string
  default = "enuygun-project"
}

variable zone {
  type = string
  default = "europe-west3-c"
}

variable region {
  type = string
  default = "europe-west3"
}