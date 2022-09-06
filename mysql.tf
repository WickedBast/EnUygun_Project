resource "google_sql_database_instance" "cloudsql" {
  name             = "cloudsql-terraform"
  database_version = "MYSQL_5_7"
  settings {
    tier              = "db-f1-micro"
    availability_type = "ZONAL"
  }
}

data "google_sql_database_instance" "cloudsql" {
    name = "cloudsql-terraform"
}

resource "random_password" "wordpress-cloudsql-password" {
  length           = 18
  special          = true
  override_special = "_%@"
}


resource "local_file" "password-file" {
  content  = random_password.wordpress-cloudsql-password.result
  filename = "./password-file"
}

resource "google_sql_user" "cloudsql-wordpress-user" {
  name     = "wordpress"
  instance = google_sql_database_instance.cloudsql.name
  host     = "%"
  password = random_password.wordpress-cloudsql-password.result
}