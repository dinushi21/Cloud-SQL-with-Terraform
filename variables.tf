variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "db_region" {
  description = "Region for Cloud SQL"
  type        = string
  default     = "us-central1"
}

variable "db_tier" {
  description = "Machine type"
  type        = string
  default     = "db-f1-micro"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "demo_db"
}

variable "db_user" {
  description = "Database user"
  type        = string
  default     = "demo_user"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "db_version" {
  description = "Database version"
  type        = string
  default     = "MYSQL_8_0"
}

variable "authorized_network_cidr" {
  description = "CIDR range allowed to connect directly (for demos only)"
  type        = string
  default     = "0.0.0.0/0"
}
