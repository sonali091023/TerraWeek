# 🚀 TerraWeek Day 6 — Advanced Terraform + Capstone Project

**Date:** Friday, 17th July 2026

The finale! 🎉 Today you'll level up with **workspaces**, the native **`terraform test`** framework, **security scanning**, **CI/CD**, and **best practices** — then tie everything together in a **Capstone Project** you can show off in interviews.

---

## 🎯 Learning Goals

- Manage multiple environments with **workspaces**.
- Automatically **format, validate, and test** Terraform (`fmt`, `validate`, `test`).
- **Scan for security issues** before you apply.
- Automate Terraform in **CI/CD** (GitHub Actions).
- Know the **production best practices** — and prove them in a capstone.

---

## 📝 Tasks

### Task 1: Workspaces & Environments
- Learn what **workspaces** are and how they isolate state per environment.
```bash
terraform workspace list
terraform workspace new staging
terraform workspace select staging
terraform workspace show
```
- Use `terraform.workspace` in your config (e.g. size things differently per env):
```hcl
locals {
  instance_type = terraform.workspace == "prod" ? "t3.medium" : "t3.micro"
}
```
- Discuss the **trade-offs**: workspaces vs separate directories/backends per environment.

**Steps to follow:**

**Workspaces & Environments:** Objective: 

**Learn:**

- What Terraform workspaces are
- How workspaces isolate state
- How to create and switch workspaces
- How to use terraform.workspace in your configuration
- The trade-offs between workspaces and separate directories/backends

**Q. What is a Terraform Workspace?**

-->A workspace is an isolated instance of Terraform state. Each workspace has its own state file, allowing you to deploy the same configuration multiple times with different infrastructure.

<img width="667" height="257" alt="image" src="https://github.com/user-attachments/assets/78cf0581-0b0d-4780-967f-c69932666573" />

-->Although the configuration is the same, each workspace manages its own infrastructure independently.

**Default Workspace:** 

-->When you initialize Terraform: terraform init [Expected: Terraform automatically creates a workspace called: default]

-->To confirm Check the current workspace: terraform workspace show [Expected: output should be default]

**List Existing Workspaces:**

-->terraform workspace list [Expected: initially we will see default workspace. And here The * indicates the currently selected workspace.]

**Create a New Workspace:** 

-->Create a staging workspace: terraform workspace new staging [Expected: Created and switched to workspace "staging"!]

-->Terraform automatically switches to the new workspace.

-->To verify: terraform workspace show [Expected: newly created workspace should be display]

-->List Again: terraform workspace list [Expected: it will shows all the available workspaces]

**Switch Workspaces:**

-->Switch back to the default workspace: terraform workspace select default

-->Now switch to staging: terraform workspace select staging

-->Create a Production Workspace: terraform workspace new prod

-->Now check the list of workspaces again: terraform workspace list [Expected: it will shows all the available workspaces]

<img width="1842" height="935" alt="image" src="https://github.com/user-attachments/assets/1ba9f757-7b00-4bc4-91d2-fece0c1420fd" />

<img width="1417" height="447" alt="image" src="https://github.com/user-attachments/assets/7a0f3d00-8369-4aa9-b51c-b3ff00aa1c64" />

**Using terraform.workspace:** Terraform exposes the name of the current workspace through the built-in variable: terraform.workspace

-->We can use it to make environment-specific decisions.

Example: EC2 Instance Type: 

<img width="682" height="452" alt="image" src="https://github.com/user-attachments/assets/52f91436-4340-4676-98dc-a65bff8e569d" />

Use it in a Resource: 

<img width="670" height="706" alt="image" src="https://github.com/user-attachments/assets/8c591e92-d4ca-40a6-9aec-c4e4cb689133" />

<img width="646" height="677" alt="image" src="https://github.com/user-attachments/assets/bacae52d-82ec-459e-ba98-9b8f2cc71882" />

<img width="1860" height="752" alt="image" src="https://github.com/user-attachments/assets/b5791a01-fcfc-4b0f-9372-92a0521b8dd2" />

<img width="1851" height="966" alt="image" src="https://github.com/user-attachments/assets/d920d98c-5ead-4f3a-8931-3afe9d51f224" />

<img width="1862" height="982" alt="image" src="https://github.com/user-attachments/assets/ee247533-781e-4f32-97e9-ab373ae3ee76" />

<img width="1835" height="975" alt="image" src="https://github.com/user-attachments/assets/03e151c2-72e4-416b-863b-6508d0cab372" />

<img width="1917" height="927" alt="image" src="https://github.com/user-attachments/assets/6da2fe7c-4352-4378-9b0c-5e89624b966d" />

<img width="1862" height="976" alt="image" src="https://github.com/user-attachments/assets/d103e7ba-eef5-4684-b0c1-193271ce8d4f" />

<img width="1872" height="961" alt="image" src="https://github.com/user-attachments/assets/47fc7723-3c95-4df5-b855-3c369ec4150d" />

<img width="1847" height="977" alt="image" src="https://github.com/user-attachments/assets/06b123ef-b84a-4efb-950f-09e50b47350c" />

<img width="1865" height="987" alt="image" src="https://github.com/user-attachments/assets/393a9c48-ccbf-4834-8a4a-08646d89e793" />

<img width="1887" height="931" alt="image" src="https://github.com/user-attachments/assets/7ca4c1c3-d227-418b-8faf-52de512bc60b" />

**Demo Commands:**

-->terraform workspace list

-->terraform workspace new staging

-->terraform workspace show

-->terraform plan

-->terraform apply

-->terraform workspace delete staging

-->Now Switch to production: terraform workspace select prod [Expected: Terraform will create a separate set of resources for the prod workspace.]

-->terraform plan

-->terraform apply

**Workspaces vs Separate Directories:**

<img width="662" height="520" alt="image" src="https://github.com/user-attachments/assets/26bd6faa-809a-40c5-8178-3e7c0c368605" />

<img width="672" height="512" alt="image" src="https://github.com/user-attachments/assets/e07c6926-1af5-4131-bf5e-4f3d0158e098" />

<img width="722" height="337" alt="image" src="https://github.com/user-attachments/assets/f236cb56-c6b2-4eb4-926f-4623271344f6" />

<img width="721" height="317" alt="image" src="https://github.com/user-attachments/assets/3e4777f3-06b8-49e6-b746-a48f86c8c962" />

**Best Practice:**
- Workspaces are great for development, testing, demos, and learning, especially when environments are very similar.
- Separate directories with separate backends are the preferred approach for production, where environments often have different configurations, stricter access controls, and independent state management. 

### Task 2: Quality Gates — `fmt`, `validate`, `test`
- Format and validate everything:
```bash
terraform fmt -recursive
terraform validate
```
- Write a **native test** with the **`terraform test`** framework (Terraform 1.6+). See [`./example/tests/basic.tftest.hcl`](./example/tests/basic.tftest.hcl):
```bash
cd example
terraform init
terraform test
```
Explain the difference between a `plan`-based `command` and an `apply`-based one in a test.

> 📚 **Reference:** [`examples/terraform_test/`](https://github.com/LondheShubham153/terraform-for-devops/tree/main/examples/terraform_test) in the companion repo shows tests asserting on bucket naming, tags, and versioning.

**Steps to follow:**

-->This task introduces Terraform Quality Gates, which help ensure your configuration is correctly formatted, valid, and behaves as expected before deployment.

**Quality Gates — fmt, validate, test:** Objective:

**Learn how to use:**
- terraform fmt → Formats Terraform code.
- terraform validate → Checks configuration syntax and consistency.
- terraform test → Runs automated tests against Terraform modules.

Step 1: Format the Code: terraform fmt -recursive

<img width="690" height="702" alt="image" src="https://github.com/user-attachments/assets/b1fc9f22-9f5c-41c7-86ca-5ddc325add54" />

Step 2: Validate the Configuration: terraform validate

<img width="660" height="401" alt="image" src="https://github.com/user-attachments/assets/73aa4956-ee39-4171-932b-e6c7af12eda6" />

Step 3: Native Terraform Testing: A typical project structure is:

<img width="1417" height="296" alt="image" src="https://github.com/user-attachments/assets/7300e0a0-2e08-49b1-9015-ee7a0613241a" />

Step 4: Initialize: cd example && terraform init

Step 5: Run Tests: terraform test

<img width="682" height="647" alt="image" src="https://github.com/user-attachments/assets/a577e29f-0f16-4625-904a-64543887c15f" />

**Example: Testing Resource Name:**

<img width="662" height="426" alt="image" src="https://github.com/user-attachments/assets/660b253d-90f2-4f89-a45c-97a62032d6c2" />

**Example: Testing Instance Type:** 

<img width="667" height="422" alt="image" src="https://github.com/user-attachments/assets/ea799b1f-0719-43ef-ac10-60625792dd82" />

<img width="692" height="527" alt="image" src="https://github.com/user-attachments/assets/1df50529-7588-4dc4-8ffe-a605ffdafed5" />

<img width="741" height="456" alt="image" src="https://github.com/user-attachments/assets/f2d6dc19-d785-409a-b75e-48dce8d02229" />

**Difference Between plan and apply:**

<img width="807" height="326" alt="image" src="https://github.com/user-attachments/assets/d71142fc-73ba-4f5d-be9d-06ec865574f3" />

**Example Test File:**

<img width="631" height="357" alt="image" src="https://github.com/user-attachments/assets/c6e6753c-246d-4318-bc56-072c5dd0e7d3" />

**Commands to Run:**

-->terraform fmt -recursive

-->terraform validate

-->terraform init

-->terraform test

<img width="1832" height="965" alt="image" src="https://github.com/user-attachments/assets/acde7b1b-ed4b-4505-8b0d-153e6b914fbb" />

**Notes for Your Submission:**

**Q. What is terraform fmt?**

-->terraform fmt automatically formats Terraform files according to the standard HashiCorp style. Using -recursive formats files in subdirectories as well.

**Q. What is terraform validate?**

-->terraform validate checks the Terraform configuration for syntax errors, invalid references, missing arguments, and overall structural correctness without creating infrastructure.

**Q. What is terraform test?**

-->terraform test is Terraform's native testing framework (introduced in Terraform 1.6) that allows automated assertions against Terraform configurations and modules.

**Q. Difference between plan and apply in tests**

-->A plan-based test evaluates the planned configuration without creating infrastructure, making it fast and safe for validation. An apply-based test creates real resources, allowing verification of provider-generated values and actual resource behavior, but it takes longer and may incur cloud costs.

### Task 3: Security & Cost Scanning
Run a static analysis tool against your Day 3 or Day 5 code and fix what it flags:
- **[Trivy](https://github.com/aquasecurity/trivy)**: `trivy config .`
- or **[Checkov](https://www.checkov.io/)**: `checkov -d .`
- or **[tfsec](https://github.com/aquasecurity/tfsec)** (now part of Trivy).
- **Bonus:** estimate cloud cost of a plan with **[Infracost](https://www.infracost.io/)**.

**Steps to follow:**

-->This task is about scanning your Terraform code for security issues, misconfigurations, and optionally estimating the cost of your infrastructure before deployment.

Since you've been using Terraform for your Day 3 and Day 5 exercises, Trivy is a great choice because it also includes the functionality that was previously in tfsec.

**Security & Cost Scanning: Objective:**

**Learn how to:**
- Scan Terraform code for security issues.
- Understand and fix common findings.
- Optionally estimate infrastructure cost before deployment.

 Option 1: Trivy: 

 <img width="770" height="765" alt="image" src="https://github.com/user-attachments/assets/bdf84b80-dd95-495a-84c9-39ea069e1e36" />

Step 2: Go to your Terraform project: 

cd ~/TerraWeek/day05/example OR cd ~/TerraWeek/day03

Step 3: Scan the Terraform code: trivy config . [Here The . means "scan the current directory."]

<img width="641" height="297" alt="image" src="https://github.com/user-attachments/assets/6945fe3f-bbe7-4a99-b718-914e3d8059e2" />

<img width="1806" height="742" alt="image" src="https://github.com/user-attachments/assets/1e3b4382-07b4-4ecc-adaf-2cc2f1f36ce9" />

<img width="1787" height="922" alt="image" src="https://github.com/user-attachments/assets/0cf3c532-8af9-4214-8a9b-904084c9f25a" />

<img width="1127" height="257" alt="image" src="https://github.com/user-attachments/assets/f9618e36-f4cc-4d0a-a785-e7f06fe9bb77" />

### Task 4: CI/CD with GitHub Actions
- Use the starter workflow at [`./example/.github-workflow-example.yml`](./example/.github-workflow-example.yml).
- Copy it to `.github/workflows/terraform.yml` in your repo.
- It runs `fmt -check`, `init`, `validate`, and `plan` on every PR. Explain each step.

**Steps to follow:**

-->This task is about automating Terraform validation using GitHub Actions. Every time someone opens or updates a Pull Request (PR), GitHub Actions automatically checks that the Terraform code is properly formatted, valid, and can generate a plan.

**CI/CD with GitHub Actions:** Objective

Create a GitHub Actions workflow that automatically runs:
- terraform fmt -check
- terraform init
- terraform validate
- terraform plan

-->on every Pull Request.

Step 1: Copy the Starter Workflow: 





### Task 5: Best Practices Checklist
Document how your capstone honors these:
- ✅ Remote state with locking (Day 4) — **never commit `.tfstate`**.
- ✅ **Pin** Terraform + provider + module versions.
- ✅ Reusable **modules** (Day 5), consistent naming & tagging.
- ✅ **No hard-coded secrets** — use variables / env / a secrets manager.
- ✅ `fmt` + `validate` + `test` + a security scan in CI.
- ✅ A clear **`README.md`** and a working `terraform destroy`.

---

## 🚫 A Note on Provisioners (`remote-exec` / `local-exec`)

You'll see older tutorials configure servers with **provisioners** over SSH. HashiCorp calls these a **last resort**, and here's why:
- They break Terraform's declarative model — Terraform can't track what a script did.
- They need SSH keys + open ingress, and fail unpredictably on retries/replacements.

**Modern alternatives (use these instead):**
- **`user_data`** / cloud-init for boot-time setup (what we used on Day 3).
- **Baked images** with Packer.
- **Config management** (Ansible) or **containers** for app-level setup.

Know provisioners exist and how to read them — but reach for them last.

---

## 🏗️ CAPSTONE PROJECT — Build Your Own Infra

Bring the whole week together. **Design and deploy a small but real project** on AWS / Azure / GCP / Utho. Ideas:
- A **2-tier web app**: VPC + public/private subnets + EC2/ASG + security groups + an S3 bucket.
- A **static website**: S3 + CloudFront (+ optional Route53).
- A **containerized app** on ECS/Fargate or a small EKS/AKS/GKE cluster.

### 🧭 Reference Implementations (companion repo)
Two production-grade blueprints to study and adapt — don't just copy, **understand and extend** them:
- 🏢 **Multi-environment app** → [`aws_module_project/`](https://github.com/LondheShubham153/terraform-for-devops/tree/main/aws_module_project): one reusable module deployed to dev/stg/prd — a great template for requirement #1 (custom module).
- ☸️ **Production EKS cluster** → [`eks/`](https://github.com/LondheShubham153/terraform-for-devops/tree/main/eks): VPC + EKS via official **registry modules** (VPC `~> 6.0`, EKS `~> 21.0`, Kubernetes **1.35**), Pod Identity, SPOT node groups. Perfect for requirements #1 **and** #2 (registry module).
  > ⚠️ **Cost warning:** an EKS cluster + 2 NAT gateways is **~$155/mo**. Only spin it up briefly and run `terraform destroy` immediately after. Beginners: start with the multi-env app.

**Requirements:**
1. Use at least **one custom module** and **one registry module**.
2. Use **remote state with native S3 locking**.
3. Drive everything with **variables** + sensible **outputs**.
4. Pass **`fmt`**, **`validate`**, a **security scan**, and at least one **`terraform test`**.
5. Wire up the **GitHub Actions** workflow.
6. Write a **`README.md`** with an architecture diagram and run instructions.
7. **`terraform destroy`** cleanly when done.

---

## 🍫 Bonus (Brownie Points)
- Use **HCP Terraform (Terraform Cloud)** for remote runs + a private module registry.
- Add **pre-commit hooks** (`terraform fmt`, `tflint`, `trivy`).
- Explore **ephemeral resources / write-only arguments** (Terraform 1.10–1.11) for secret handling.
- Try **OpenTofu** as a drop-in and compare.

---

## 📤 What to Submit (Final!)
- A blog / LinkedIn / X post with your **capstone architecture**, code repo link, and demo screenshots.
- Your complete **GitHub repo** for the whole week.
- Tag **#TrainWithShubham #TerraWeekChallenge**, tag **[@Shubham Londhe](https://www.linkedin.com/in/shubhamlondhe1996/)**, and share with your network.

> 🎓 Completed all 6 days + learned in public? You've earned your **Python For DevOps [AI Powered] Cohort** access — and a shot at the **Top 3** prize! 🏆

---

📺 **Companion video:** [Terraform In One Shot](https://youtu.be/S9mohJI_R34) (Project 3 — EKS + testing & best practices)
💻 **Companion code:** [`examples/terraform_test/`](https://github.com/LondheShubham153/terraform-for-devops/tree/main/examples/terraform_test) · [`eks/`](https://github.com/LondheShubham153/terraform-for-devops/tree/main/eks) · [Testing docs](https://developer.hashicorp.com/terraform/language/tests) · [Best Practices](https://developer.hashicorp.com/terraform/cloud-docs/recommended-practices)
💬 Questions? [Discord](https://discord.gg/hs3Pmc5F) / [Telegram](https://t.me/trainwithshubham).

### 🎉 Congratulations on completing the TWS TerraWeek Challenge 2026! Happy Terraforming! 🌍💻
