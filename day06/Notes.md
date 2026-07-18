# Terraform Best Practices Checklist

## 1. Remote State with Locking

**Implemented:** ✅

- Terraform state is stored remotely in an Amazon S3 bucket.
- State locking is enabled using a DynamoDB table.
- This prevents multiple users from modifying the state simultaneously.
- The `.tfstate` file is excluded from version control using `.gitignore`.

Example:

```hcl
terraform {
  backend "s3" {
    bucket         = "terraweek-state-bucket"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
  }
}
```

`.gitignore`

```gitignore
*.tfstate
*.tfstate.*
.terraform/
terraform.tfvars
```

---

## 2. Version Pinning

**Implemented:** ✅

Terraform version is pinned:

```hcl
terraform {
  required_version = ">= 1.6.0"
}
```

AWS Provider:

```hcl
required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 6.0"
  }
}
```

Registry Module:

```hcl
module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "5.15.1"
}
```

Version pinning ensures reproducible deployments and avoids unexpected breaking changes.

---

## 3. Reusable Modules

**Implemented:** ✅

The project uses reusable modules for infrastructure components.

Example:

```hcl
module "servers" {
  source   = "./modules/ec2_instance"
  for_each = toset(["app", "worker", "cache"])
}
```

Benefits:

- Code reuse
- Easier maintenance
- Consistent infrastructure
- Modular design

---

## 4. Consistent Naming and Tagging

**Implemented:** ✅

Resources follow a consistent naming convention.

Example:

```hcl
locals {
  common_tags = {
    Project     = "TerraWeek"
    Environment = terraform.workspace
    Owner       = "Sonali"
    ManagedBy   = "Terraform"
  }
}
```

These tags are reused across EC2, VPC, and S3 resources.

---

## 5. No Hard-coded Secrets

**Implemented:** ✅

Sensitive values are **not** stored in Terraform files.

Secrets are provided using:

- Terraform variables
- Environment variables
- AWS credentials
- (Recommended) AWS Secrets Manager

Example:

```bash
export AWS_ACCESS_KEY_ID=xxxx
export AWS_SECRET_ACCESS_KEY=xxxx
```

The following files are excluded from Git:

```gitignore
terraform.tfvars
*.tfstate
```

---

## 6. Code Quality Checks

**Implemented:** ✅

Terraform code is verified using:

```bash
terraform fmt -recursive
terraform validate
terraform test
```

Security scanning:

```bash
trivy config .
```

CI/CD automatically executes:

- terraform fmt -check
- terraform init
- terraform validate
- terraform plan

using GitHub Actions.

---

## 7. Documentation

**Implemented:** ✅

The repository includes a detailed README describing:

- Project overview
- Prerequisites
- Installation
- Terraform commands
- Module structure
- Outputs
- Cleanup instructions

---

## 8. Resource Cleanup

**Implemented:** ✅

Infrastructure can be removed safely using:

```bash
terraform destroy
```

Destroying infrastructure helps prevent unnecessary cloud costs.
