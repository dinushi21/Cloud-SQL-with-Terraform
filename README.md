# Cloud SQL with Terraform (practice project)

This repository is my practice implementation of deploying a Google Cloud SQL instance using Terraform and connecting via Cloud SQL Proxy. It started from a Google Cloud / Coursera guided lab, but I rebuilt and adapted it to understand Terraform workflows, remote state, and basic database admin on GCP.

---

## What this project does

- Creates a Cloud SQL instance (MySQL by default) with a demo database and user.
- Enables:
  - Automated backups
  - Point-in-time recovery
  - Regional (HA) configuration
  - Maintenance window
  - SSL requirement
  - Deletion protection
- Outputs key connection details:
  - Instance connection name
  - Public IP
  - Database name
  - Username

---

## Tech stack

- **Terraform**
- **Google Cloud Platform (GCP)**
- **Cloud SQL** (MySQL, optionally PostgreSQL)
- **Cloud SQL Proxy**

---

## Project structure

```text
cloud-sql-terraform-lab/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars.example
└── screenshots/   # (optional) my own screenshots from the GCP console


---

## How to use

> You need your own Google Cloud project, credentials, and a GCS bucket for remote state (recommended).

1) Clone the repo

```bash
git clone https://github.com/<dinushi21>/cloud-sql-terraform-lab.git
cd cloud-sql-terraform-lab
```

2) Configure remote state (recommended)

Edit the `backend "gcs"` block in `main.tf` with your bucket name and a prefix, then run:

```bash
terraform init
```

(You can also pass `-backend-config="bucket=..." -backend-config="prefix=..."`.)

3) Create your terraform.tfvars

```bash
cp terraform.tfvars.example terraform.tfvars
```

Replace placeholders with your values. Use a narrow CIDR (single IP /32) for `authorized_network_cidr` if you keep public IPv4 enabled.

4) Review and apply

```bash
terraform plan
terraform apply
```

---

## Connect using Cloud SQL Proxy

Example (MySQL):

```bash
./cloud_sql_proxy -instances=<cloud-sql-demo-478718:us-central1:demo-cloud-sql-instance>=tcp:3306
mysql -u demo_user -p --host 127.0.0.1 --port 3306
```

---

## Notes

- Do not commit real credentials or service account keys; store them securely outside version control.
- The defaults keep public IPv4 enabled but lock access to the CIDR you provide. For production, prefer private IP and VPC connectivity.
- Delete protection is on by default; disable intentionally if you need to destroy the instance.
