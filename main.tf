terraform {
  required_version = ">= 1.3.0"

  backend "gcs" {
    # Replace with your remote state bucket and optional prefix before running `terraform init`.
    bucket = "REPLACE_WITH_YOUR_TF_STATE_BUCKET"
    prefix = "cloud-sql-terraform"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.db_region
}

resource "google_sql_database_instance" "cloud_sql_instance" {
  name             = "demo-cloud-sql-instance"
  database_version = var.db_version
  region           = var.db_region

  settings {
    availability_type = "REGIONAL"
    tier = var.db_tier

    backup_configuration {
      enabled                        = true
      point_in_time_recovery_enabled = true
    }

    maintenance_window {
      day          = 7   # Sunday
      hour         = 3   # 03:00 UTC
      update_track = "stable"
    }

    ip_configuration {
      ipv4_enabled = true
      require_ssl  = true

      authorized_networks {
        name  = "allowed-cidr"
        value = var.authorized_network_cidr
      }
    }
  }

  deletion_protection = true
}

resource "google_sql_database" "demo_database" {
  name     = var.db_name
  instance = google_sql_database_instance.cloud_sql_instance.name
}

resource "google_sql_user" "demo_user" {
  name     = var.db_user
  instance = google_sql_database_instance.cloud_sql_instance.name
  password = var.db_password
}
