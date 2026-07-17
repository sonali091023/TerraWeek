# 🗄️ TerraWeek Day 4 — State & Remote Backends (Native Locking)

**Date:** Wednesday, 15th July 2026

Terraform's **state** is the single most important concept for working on a **team**. Today you'll understand what state is, why it's sensitive, and how to store it **remotely and safely** — using the **modern S3 native state locking** (no DynamoDB needed anymore!). 🔐

---

## 🎯 Learning Goals

- Understand **what Terraform state is** and why it exists.
- Use the **`terraform state`** commands to inspect and manipulate state.
- Move from **local** to **remote** state with an **S3 backend**.
- Enable **S3 native state locking** with `use_lockfile` (the 2026 way).
- Safely **import** existing resources into state.

---

## 🆕 What Changed (Important!)

> The old TerraWeek taught **S3 + DynamoDB** for state locking.
> As of **Terraform 1.10** (experimental) and **1.11** (GA), the S3 backend supports **native locking** via a lock file in the bucket — using S3 conditional writes.
> **DynamoDB-based locking is now deprecated** and will be removed in a future release.
> ➡️ For all new work, use **`use_lockfile = true`** and skip DynamoDB entirely.

---

## 📝 Tasks

### Task 1: Why State Matters
Explain in your notes:
- What is the **`terraform.tfstate`** file and what does it store?
- Why should you **never** edit it by hand or commit it to Git?
- What is **state drift**, and how does `terraform plan` / `terraform refresh` relate to it?
- Why is state **sensitive** (it can contain secrets in plaintext)? 

Steps to follow:

-->This task is about one of the most important Terraform concepts. Terraform's state file is what allows Terraform to know what it has already 
created so it can safely update or delete infrastructure later.

Task 1: Why State Matters: 

**1. What is the terraform.tfstate file?**
- The terraform.tfstate file is a JSON file that Terraform creates automatically after running terraform apply.
- It stores Terraform's current knowledge of your infrastructure.
- Think of it as Terraform's memory.
- Without the state file, Terraform would not know:
  - which resources already exist
  - which resources it created
  - the IDs assigned by the cloud provider
  - what changes need to be made
<img width="887" height="557" alt="image" src="https://github.com/user-attachments/assets/82fa6c07-3d68-4e08-9efe-105a1acd54a7" />
<img width="885" height="787" alt="image" src="https://github.com/user-attachments/assets/ebe5be75-6fa3-434f-af2e-1dbf996ae3c4" />

**Q. Why Terraform Needs State?**

-->Imagine Terraform did not have a state file. Like if we run **terraform apply** command Terraform creates EC2 Instance A, Then the next day you run **terraform apply**, 
So Without state Terraform cannot know that the instance already exists. It might try to create another EC2 instance. The state file prevents this. 

-->It lets Terraform compare: 
<img width="762" height="126" alt="image" src="https://github.com/user-attachments/assets/a454ea03-7175-4c4c-8e22-517ad9ad0f89" />

Then Terraform performs only the necessary changes.

**2. Why should you NEVER edit it manually?**

-->Although it is just JSON, you should never edit it by hand.
<img width="732" height="740" alt="image" src="https://github.com/user-attachments/assets/aa3bb6f0-e1c8-457f-a520-d48041ace7f5" />
<img width="687" height="577" alt="image" src="https://github.com/user-attachments/assets/3049f69e-66b7-41a2-8ed9-6969260e6817" />

**Q. Why should you never commit it to Git?**

-->The state file often contains sensitive information.
<img width="711" height="632" alt="image" src="https://github.com/user-attachments/assets/1a8c8c98-410e-44fc-93f5-41f7ff19ba1f" />

**3. What is State Drift?**

-->State drift happens when the real infrastructure changes outside Terraform, so the actual infrastructure no longer matches Terraform's recorded state or configuration.
<img width="712" height="592" alt="image" src="https://github.com/user-attachments/assets/403ee34f-1ff2-4b70-a919-63b1f7baf045" />
<img width="710" height="582" alt="image" src="https://github.com/user-attachments/assets/9a11059b-7eb6-4014-a1fe-1da871a9cb5f" />
<img width="741" height="605" alt="image" src="https://github.com/user-attachments/assets/9ad207f9-aa73-4286-9556-34e6b1604fbc" />

**Note:** In modern Terraform versions, terraform refresh is largely replaced by terraform apply -refresh-only, and terraform plan automatically refreshes state before generating a plan.

**4. Why is State Sensitive?**

-->The state file can contain sensitive data in plaintext.
<img width="677" height="397" alt="image" src="https://github.com/user-attachments/assets/b30abf3d-ec95-4e35-8c2c-6c7dca53c7c9" />

-->Even if a Terraform variable is marked as sensitive, the value may still be stored in the state file so Terraform can manage the resource correctly. 
The sensitive flag mainly hides the value from CLI output—it does not necessarily encrypt it in the state.

-->If someone gains access to your state file, they could potentially access critical parts of your infrastructure.

**Best Practices for Managing State:**
- Never edit terraform.tfstate manually.
- Do not commit state files to Git.
- Store state remotely (for example, in an S3 bucket with encryption and state locking via DynamoDB, or another supported backend).
- Restrict access to the state file using IAM permissions.
- Encrypt remote state at rest and in transit.
- Regularly back up your state.

**Interview Summary:**

**Q: What is the Terraform state file?**

-->The terraform.tfstate file is Terraform's record of the infrastructure it manages. It stores resource metadata, IDs, attributes, and mappings between the Terraform configuration and real infrastructure.

**Q: Why shouldn't you edit it manually?**

-->Manual edits can corrupt the file or create inconsistencies, leading Terraform to manage resources incorrectly. Use terraform state commands instead.

**Q: What is state drift?**

-->State drift occurs when infrastructure is modified outside Terraform, causing the actual infrastructure to differ from Terraform's expected configuration. terraform plan detects drift, and a refresh operation updates the state to match reality.

**Q: Why is the state file sensitive?**

-->It can contain infrastructure metadata and sensitive values such as passwords, tokens, and connection details in plaintext. For this reason, it should never be committed to Git and should be stored securely using an encrypted remote backend.

### Task 2: Explore Local State & `terraform state`
Start from **any** working config (reuse Day 3's, or the [`./backend_demo`](./backend_demo) here). After an `apply`, practice:
```bash
terraform state list                       # list all managed resources
terraform state show <resource_address>    # inspect one resource
terraform state mv <src> <dest>            # rename/move within state
terraform state rm <resource_address>      # stop managing (does NOT delete infra)
terraform show                             # human-readable state
```
Document what each command does and when you'd use it.

**Steps to follow:**

-->This task is designed to help you understand how to inspect and manage Terraform state using the terraform state command. Since you've already worked with 
Terraform and AWS EC2 instances, you can reuse one of your existing projects.

**Explore Local State & terraform state:**

**Prerequisites:** Use any working Terraform project, for example:

-->cd terraform-practice

-->cd backend_demo [Ensure resources already exist:

-->terraform init

-->terraform apply

-->Verify the state file exists: ls

-->Example output: main.tf, terraform.tfstate, terraform.tfstate.backup

Step 1: List All Managed Resources: 

-->terraform state list

<img width="657" height="287" alt="image" src="https://github.com/user-attachments/assets/6cf4423f-bc41-4f62-b23d-5f6b1a3536c7" />

**Q. What does it do?**

-->It lists every resource currently tracked in the Terraform state. Terraform is saying: "These are all the resources I'm managing."

**Q. When would you use it?**
- Check what Terraform manages.
- Find the correct resource address.
- Before using terraform state show.
- Before importing or moving resource

Step 2: Inspect a Resource: Choose one resource from the previous command.

Eg: terraform state show aws_instance.web
<img width="747" height="322" alt="image" src="https://github.com/user-attachments/assets/c0a4f410-1eda-43b6-9094-89a6602ed687" />

**Q. What does it do?**
-->Shows every attribute Terraform knows about that resource.
-->Unlike your .tf file, this includes values assigned by AWS after creation, such as:
- Instance ID
- Public IP
- Private IP
- ARN
- Availability Zone

**Q. When would you use it?**
- Debug infrastructure.
- Find resource IDs.
- Verify tags.
- Inspect computed values.

Step 3: Move a Resource in State: Suppose your configuration originally had:
<img width="712" height="557" alt="image" src="https://github.com/user-attachments/assets/01033461-48d7-4ac4-b2a7-1a1464312e74" />

-->Instead, move the state: terraform state mv aws_instance.web aws_instance.frontend
<img width="740" height="370" alt="image" src="https://github.com/user-attachments/assets/003a2d14-860d-40dc-b64b-caff85fa2dc2" />

**Q. What does it do?**
-->It renames or relocates a resource inside the state file without changing the actual infrastructure.

**Q. When would you use it?**
- Renaming resources.
- Refactoring Terraform code.
- Moving resources into modules.
- Preventing unnecessary recreation.

Step 4: Remove a Resource from State: 
<img width="707" height="357" alt="image" src="https://github.com/user-attachments/assets/f15874dd-207d-4339-b79d-4740061421b2" />

**Q. What happened?**

-->Terraform forgets the EC2 instance. However: The EC2 instance is still running in AWS. Terraform simply no longer manages it.

-->To verify run command: terraform state list, The resource is gone. But in AWS Console: EC2 instance still exists

**Q. What does it do?**

-->Removes a resource from Terraform state without deleting the real infrastructure.

**Q. When would you use it?**
- Stop managing a resource.
- Hand it over to another Terraform project.
- Recover from state problems.
- Before importing into another state.

Step 5: Display the Entire State: terraform show
<img width="707" height="297" alt="image" src="https://github.com/user-attachments/assets/fb4ab648-717c-4471-9d81-da7067b96179" />

**Q. What does it do?**

-->Shows all resources in a readable format.
<img width="637" height="192" alt="image" src="https://github.com/user-attachments/assets/599f79f2-dfc5-4835-9a9e-430b5df50ffe" />

**Q. When would you use it?**
- Review infrastructure.
- Troubleshoot state.
- Inspect resource values.
- Understand what Terraform currently manages.

**Visual Summary:**
<img width="661" height="341" alt="image" src="https://github.com/user-attachments/assets/987e31b4-7a99-43ef-9330-4e9885285cfb" />

Command Summary:

<img width="1105" height="357" alt="image" src="https://github.com/user-attachments/assets/b4268b6c-a6ac-41e3-a5f5-a32a773988bc" />

**Important Notes:**
- terraform state mv only updates the state file. It does not rename or recreate the actual AWS resource.
- terraform state rm only removes Terraform's tracking. The infrastructure remains unchanged.
- Avoid editing terraform.tfstate manually—use terraform state commands instead.
- Always run terraform plan after state mv or state rm to verify the resulting changes before applying anything.

**Interview Questions:**

**Q1: What does terraform state list do?**

-->It lists all resources currently tracked in the Terraform state.

**Q2: What is terraform state show used for?**

-->It displays detailed information about a specific managed resource, including computed attributes like IDs and IP addresses.

**Q3: Does terraform state mv recreate infrastructure?**

-->No. It only updates the resource's address in the state file, allowing code refactoring without recreating resources.

**Q4: Does terraform state rm delete AWS resources?**

-->No. It removes the resource from Terraform's state, but the actual infrastructure continues to exist.

**Q5: Why use terraform show instead of opening terraform.tfstate?**

-->terraform show presents the state in a human-readable format, while terraform.tfstate is raw JSON intended for Terraform's internal use.





### Task 3: Bootstrap the Backend Infrastructure
The S3 bucket that *holds* your state must exist **before** you configure the backend. Use [`./backend_infra`](./backend_infra) to create it (**local** state for this bootstrap step only):
```bash
cd backend_infra
terraform init
terraform apply    # creates the versioned, encrypted S3 state bucket
```

**Steps to follow:**

-->This task introduces Terraform Remote State. The key idea is that Terraform cannot store its state in an S3 bucket until that bucket already exists, so you 
first create the bucket using local state. This one-time setup is called bootstrapping the backend.

**Bootstrap the Backend Infrastructure:**

-->Objective: Create an S3 bucket that will later store your Terraform state, During this step:
- State is stored locally (terraform.tfstate).
- Terraform creates the S3 bucket.
- After the bucket exists, you can configure future projects to use it as a remote backend.

**Q. Why do we need a bootstrap step?**
-->Imagine your backend configuration is:
<img width="692" height="197" alt="image" src="https://github.com/user-attachments/assets/6ad9b1e3-8c74-4717-9fa3-2b31ad9518e4" />
-->When you run: terraform init

-->Terraform immediately tries to connect to: my-terraform-state-bucket

-->But if the bucket doesn't exist yet, you'll get an error like: Error: S3 bucket does not exist

-->Terraform can't create the bucket because it wants to store its state there before running any resources.

This creates a chicken-and-egg problem:
<img width="682" height="262" alt="image" src="https://github.com/user-attachments/assets/d7fddfc9-c85b-4de4-87e6-c9b3ee2674ea" />

Step 1: Go to the bootstrap project: 

-->cd backend_infra

-->Check the files: ls [Expected: main.tf, variables.tf, outputs.tf]

Step 2: Initialize Terraform: terraform init





### Task 4: Configure the Remote Backend with Native Locking
Now point a real config at that bucket. See [`./backend_demo`](./backend_demo):
```hcl
terraform {
  backend "s3" {
    bucket       = "your-unique-terraweek-state-bucket"
    key          = "day04/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true   # ✅ native S3 state locking — no DynamoDB!
  }
}
```
```bash
cd backend_demo
terraform init     # Terraform will offer to migrate local state → S3
terraform apply
```
Verify in the S3 console that your `terraform.tfstate` is uploaded, and watch a `.tflock` file appear/disappear during an apply.

### Task 5: Import an Existing Resource
Create something manually in the console (e.g. an S3 bucket), then bring it under Terraform management using an **`import` block** (Terraform 1.5+):
```hcl
import {
  to = aws_s3_bucket.imported
  id = "my-manually-created-bucket"
}
```
Run `terraform plan -generate-config-out=generated.tf` and review the generated config.

> 📚 **Reference the companion repo** for the full set of state/refactor blocks, each in a commented file:
> [`examples/import.tf`](https://github.com/LondheShubham153/terraform-for-devops/blob/main/examples/import.tf) · [`examples/moved.tf`](https://github.com/LondheShubham153/terraform-for-devops/blob/main/examples/moved.tf) · [`examples/removed.tf`](https://github.com/LondheShubham153/terraform-for-devops/blob/main/examples/removed.tf) · [`examples/check.tf`](https://github.com/LondheShubham153/terraform-for-devops/blob/main/examples/check.tf)

---

## 🧹 Cleanup
```bash
cd backend_demo && terraform destroy
cd ../backend_infra && terraform destroy   # empty the bucket first if versioning blocks it
```

---

## 🍫 Bonus (Brownie Points)
- Compare remote backends: **S3**, **HCP Terraform (Terraform Cloud)**, **Azure Storage**, **GCS**.
- Enable **S3 bucket versioning** and recover a previous state version.
- Try the **`moved`** block to refactor resource addresses without destroy/recreate ([`examples/moved.tf`](https://github.com/LondheShubham153/terraform-for-devops/blob/main/examples/moved.tf)).
- Use a **`removed`** block to stop managing a resource *without deleting it* ([`examples/removed.tf`](https://github.com/LondheShubham153/terraform-for-devops/blob/main/examples/removed.tf)).
- Add a **`check`** block for a continuous health assertion ([`examples/check.tf`](https://github.com/LondheShubham153/terraform-for-devops/blob/main/examples/check.tf)).

---

## 📤 What to Submit
- Blog / LinkedIn / X post: your backend config, a screenshot of state in S3, and the lock file appearing during `apply`.
- Push to your GitHub repo (**remember: never commit `.tfstate`!**). Tag **#TrainWithShubham #TerraWeekChallenge**.

---

📺 **Companion video:** [Terraform In One Shot](https://youtu.be/S9mohJI_R34) (state, backends & refactoring blocks)
💻 **Companion code:** [`examples/import.tf`](https://github.com/LondheShubham153/terraform-for-devops/blob/main/examples/import.tf) · [`moved.tf`](https://github.com/LondheShubham153/terraform-for-devops/blob/main/examples/moved.tf) · [`removed.tf`](https://github.com/LondheShubham153/terraform-for-devops/blob/main/examples/removed.tf) · [S3 Backend docs](https://developer.hashicorp.com/terraform/language/backend/s3)
💬 Questions? [Discord](https://discord.gg/hs3Pmc5F) / [Telegram](https://t.me/trainwithshubham).

### Happy Terraforming! 🌍💻
