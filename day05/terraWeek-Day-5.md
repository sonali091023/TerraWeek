# 📦 TerraWeek Day 5 — Modules: Reusable, Composable Infrastructure

**Date:** Thursday, 16th July 2026

Copy-pasting `.tf` blocks doesn't scale. **Modules** let you package infrastructure once and reuse it everywhere — across environments, teams, and projects. Today you'll **write your own module**, **consume registry modules**, and learn **versioning**. ♻️

---

## 🎯 Learning Goals

- Understand **what modules are** and why they're the backbone of scalable Terraform.
- Understand the **root module** vs **child modules**.
- Write a **local module** with clear **inputs (variables)** and **outputs**.
- Consume modules from the **Terraform Registry** and **Git**, and **pin versions**.
- Use **`for_each`** to instantiate a module multiple times.

---

## 📝 Tasks

  ### Task 1: Modules — the Why
  Answer in your notes:
  - What is a **module**? What counts as the **root module**?
  - What are the benefits — **reusability, consistency, encapsulation, versioning, testing**?
  - What files make up a well-structured module (`main.tf`, `variables.tf`, `outputs.tf`, `README.md`)?

**Steps to follow:**

-->This task is about understanding why Terraform modules exist and how they help organize infrastructure code.

Task 1: Modules — The Why:

**1. What is a Module?:**

-->A Terraform module is a collection of .tf files that work together to create one or more infrastructure resources.

-->Instead of writing the same Terraform code repeatedly, you can group related resources into a module and reuse it wherever needed.

-->Think of a module like a function in programming:
   - A function groups related code to perform a specific task.
   - A module groups related infrastructure code to provision a specific set of resources.

-->For example:
- An EC2 module creates EC2 instances.
- A VPC module creates networking resources.
- An S3 module creates storage buckets.

<img width="682" height="526" alt="image" src="https://github.com/user-attachments/assets/5ac50e32-9463-4b7b-9603-2a1af8ca35c6" />

**2. What is the Root Module?**

-->The root module is the Terraform configuration in the directory where you run Terraform commands such as:
- terraform init
- terraform plan
- terraform apply
- terraform destroy

-->Terraform always starts execution from the current working directory. That directory is called the root module. The root module usually:
- Configures the provider
- Defines backend settings
- Calls child modules
- Passes variables to child modules

<img width="702" height="602" alt="image" src="https://github.com/user-attachments/assets/6e7470de-d00e-43c4-ab5a-392287db5340" />

Benefits of Terraform Modules:

--> **1. Reusability:** A module can be used multiple times without duplicating code. Instead of writing the same EC2 configuration repeatedly, create one module and call it whenever needed.

<img width="701" height="347" alt="image" src="https://github.com/user-attachments/assets/d1d501cb-16e9-4984-a6bc-34743e0f90cc" />

**Benefits:**
- Less duplicated code
- Faster development
- Easier maintenance

--> **2. Consistency:** Every environment uses the same infrastructure definitions. For example:
- Development
- Staging
- Production

-->can all use the same VPC module. This ensures:
- Same resource structure
- Same security settings
- Same naming conventions

-->Consistency reduces configuration mistakes.

--> **3. Encapsulation:** A module hides its internal implementation. & Users only provide the required inputs and receive outputs. For example:

<img width="685" height="337" alt="image" src="https://github.com/user-attachments/assets/e8203daf-b80d-497a-8869-808a55e0291a" />

-->The user doesn't need to know how everything is created internally. This makes modules easier to use and maintain.

**4. Versioning:** Modules can have different versions. Projects can choose a specific version instead of automatically using the latest.

<img width="742" height="352" alt="image" src="https://github.com/user-attachments/assets/974aaa26-7263-4aec-a3dd-4adde86b9862" />

Benefits:
- Stable infrastructure
- Safe upgrades
- Rollback capability
- Predictable deployments

--> **5. Testing:** Because modules are independent, they can be tested individually before being used in larger projects.For example: 
- Test the EC2 module.
- Verify that it creates the correct instance.
- Reuse the tested module in multiple projects.

Benefits:

Fewer bugs
Easier debugging
Greater confidence before deployment

**Files in a Well-Structured Module:** A Terraform module is usually organized with the following files:

<img width="602" height="566" alt="image" src="https://github.com/user-attachments/assets/e021f61c-ac41-4a08-8d39-23e9abefec63" />

<img width="647" height="471" alt="image" src="https://github.com/user-attachments/assets/8ca859fe-5732-4945-addb-a5b96702a4cb" />

<img width="675" height="462" alt="image" src="https://github.com/user-attachments/assets/4948e895-1009-4acb-bb15-c9b8ec68c2b3" />

4. README.md:

<img width="497" height="337" alt="image" src="https://github.com/user-attachments/assets/16a422a2-0350-4eb0-8366-dc14ec58534f" />

<img width="760" height="581" alt="image" src="https://github.com/user-attachments/assets/d841c9d3-fa6e-4f43-be9c-f76c923bdbd8" />

**Summary Table:**

<img width="857" height="596" alt="image" src="https://github.com/user-attachments/assets/97e1d72d-8672-4f45-a9a8-2ec5cc2bd6e7" />

Q. What is the difference between the root module and a child module?"

--> **Root module:** The top-level Terraform configuration where you run commands like terraform init, terraform plan, and terraform apply. It acts as the entry point and usually calls other modules.

--> **Child module:** Any module that is called by another module (typically the root module) using a module block. It encapsulates a specific piece of infrastructure that can be reused across projects.

### Task 2: Write Your Own Module
Use the **starter code in [`./example`](./example)**. It contains:
- A reusable module at [`./example/modules/ec2_instance`](./example/modules/ec2_instance)
- A **root module** ([`./example`](./example)) that calls it.

Study how the root resolves shared lookups **once** (AMI, subnet, security group) and passes them as **inputs**, then reads the module's **outputs**:
```hcl
module "web_server" {
  source                 = "./modules/ec2_instance"
  name                   = "web"
  instance_type          = "t2.micro"
  environment            = "dev"
  ami                    = data.aws_ami.al2023.id   # resolved in the root
  subnet_id              = local.subnet_id
  vpc_security_group_ids = local.security_group_ids
}

output "web_public_ip" {
  value = module.web_server.public_ip
}
```
> 💡 Notice the module takes **IDs as inputs** instead of doing its own lookups. That keeps it reusable and avoids running the same data source once per instance.
```bash
cd example
terraform init      # note how Terraform initializes the module
terraform plan
terraform apply
terraform destroy
```

### Task 3: Modular Composition (`for_each`)
Instantiate the **same module multiple times** to build multiple servers cleanly:
```hcl
module "servers" {
  source   = "./modules/ec2_instance"
  for_each = toset(["app", "worker", "cache"])

  name                   = each.key
  instance_type          = "t2.micro"
  environment            = "dev"
  ami                    = data.aws_ami.al2023.id
  subnet_id              = local.subnet_id
  vpc_security_group_ids = local.security_group_ids
}
```
Add this to the root module and observe the plan.

### Task 4: Consume a Registry Module + Version Locking
Use a real, popular module from the **[Terraform Registry](https://registry.terraform.io/)** — e.g. the official AWS VPC module — and **pin its version**:
```hcl
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"   # ✅ always pin registry/git module versions

  name = "terraweek-vpc"
  cidr = "10.0.0.0/16"
  # ...
}
```

### Task 5: Ways to Lock Module Versions
Document, with code snippets, **each** way to pin a module source:
- **Registry:** `version = "~> 5.0"` (also `= 5.1.2`, `>= 5.0, < 6.0`).
- **Git tag/ref:** `source = "git::https://github.com/org/repo.git//path?ref=v1.2.0"`.
- **Git commit SHA** for immutability: `?ref=<full-sha>`.
Explain why **pinning matters** (reproducible builds, no surprise breaking changes).

---

> 📚 **Reference the companion repo:** [`aws_module_project/`](https://github.com/LondheShubham153/terraform-for-devops/tree/main/aws_module_project) is a real multi-environment example — one reusable [`my_app_infra_module`](https://github.com/LondheShubham153/terraform-for-devops/tree/main/aws_module_project/my_app_infra_module) (EC2 + S3 + DynamoDB) instantiated three times for **dev / stg / prd** with different instance sizes. Study how [`main.tf`](https://github.com/LondheShubham153/terraform-for-devops/blob/main/aws_module_project/main.tf) passes inputs and reads outputs.

## 🧠 `~>` (Pessimistic Constraint) Cheatsheet
- `~> 5.0` → allows `5.x`, **not** `6.0`.
- `~> 5.1.0` → allows `5.1.x`, **not** `5.2.0`.

---

## 🍫 Bonus (Brownie Points)
- Add a **`README.md`** and input **validation** to your module.
- Publish your module to your **own GitHub** and consume it via a `git::` source + `?ref=` tag.
- Explore **module composition**: pass one module's output as another module's input.

---

## 📤 What to Submit
- Blog / LinkedIn / X post: your module structure, the root config calling it, and `terraform plan` showing multiple instances via `for_each`.
- Push to your GitHub repo. Tag **#TrainWithShubham #TerraWeekChallenge**.

---

📺 **Companion video:** [Terraform In One Shot](https://youtu.be/S9mohJI_R34) (Project 2 — reusable multi-env module)
💻 **Companion code:** [`aws_module_project/`](https://github.com/LondheShubham153/terraform-for-devops/tree/main/aws_module_project) · [Modules docs](https://developer.hashicorp.com/terraform/language/modules) · [Terraform Registry](https://registry.terraform.io/)
💬 Questions? [Discord](https://discord.gg/hs3Pmc5F) / [Telegram](https://t.me/trainwithshubham).

### Happy Terraforming! 🌍💻
