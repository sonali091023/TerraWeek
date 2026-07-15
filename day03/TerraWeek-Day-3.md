# ☁️ TerraWeek Day 3 — Providers, Resources & Your First Cloud Infra

**Date:** Tuesday, 14th July 2026

Time to touch **real cloud infrastructure**! Today you'll configure a **provider**, use **data sources** and **meta-arguments** (`for_each`, `count`, `depends_on`, `lifecycle`), and provision a small network + compute stack on the cloud of your choice. 🏗️

---

## 🎯 Learning Goals

- Configure a **provider** properly with **version pinning** and **region**.
- Understand **resources** vs **data sources**.
- Use meta-arguments: **`count`**, **`for_each`**, **`depends_on`**, **`lifecycle`**.
- Provision, update, and destroy real cloud resources safely.

---

## ⚙️ Setup: Authenticate Your Cloud

Pick **one** provider and configure its CLI (never hard-code credentials in `.tf` files!):

- **AWS** → `aws configure` (uses `~/.aws/credentials`) — provider `hashicorp/aws ~> 6.0`
- **Azure** → `az login` — provider `hashicorp/azurerm ~> 4.0`
- **GCP** → `gcloud auth application-default login` — provider `hashicorp/google ~> 6.0`
- **Utho** → API token env var — provider `uthoplatforms/utho`

---

## 🗺️ 60-Second Networking Primer (read this first!)

Today jumps from a single container to a real cloud network. Don't panic — here are the **6 building blocks** you'll create, in plain English:

| Block | What it is | Real-world analogy |
|-------|------------|--------------------|
| **VPC** | Your own private, isolated network in the cloud (a range of IPs like `10.0.0.0/16`) | Your own gated neighborhood |
| **Subnet** | A slice of the VPC's IPs (`10.0.1.0/24`), lives in one Availability Zone | A street in that neighborhood |
| **Internet Gateway (IGW)** | The door between your VPC and the public internet | The neighborhood's main gate |
| **Route Table** | Rules that say "traffic for the internet → go via the IGW" | Road signs / GPS routes |
| **Security Group (SG)** | A stateful virtual firewall on the instance (which ports are open) | A bouncer checking who gets in |
| **EC2 Instance** | The actual virtual machine running your app | A house on the street |

**How they connect:** an **EC2 instance** lives in a **subnet**, inside a **VPC**. To reach the internet, the subnet's **route table** sends traffic through the **IGW**, and the **security group** decides which ports (e.g. 80/HTTP) are allowed in.

```
Internet ──▶ [IGW] ──▶ [Route Table] ──▶ [ Public Subnet ] ──▶ [SG] ──▶ [EC2]
                                          (inside the VPC)
```

> 💡 You'll build exactly this stack in Task 3. Re-read this table if a resource name ever feels confusing.

---

## 📝 Tasks

### Task 1: Providers & Version Pinning
- Add a `terraform` block with `required_version` and `required_providers` (pin with `~>`).
- Explain **why version pinning matters** and what the `~>` (pessimistic) operator does.
- **Bonus:** configure a second provider **alias** (e.g. a second AWS region) and explain when you'd use it.

**Steps to follow:**

-->This task is about understanding Terraform Providers, version pinning, and provider aliases. Let's complete it step by step.

Task 1: Providers & Version Pinning: Create versions.tf file: vi versions.tf

<img width="456" height="322" alt="image" src="https://github.com/user-attachments/assets/a5342716-9be6-4545-a1df-6527a2ac3d4e" />

Step 2: Configure the Provider: Create provider.tf: vi providers.tf

<img width="537" height="147" alt="image" src="https://github.com/user-attachments/assets/d2448581-8009-4cac-858c-49d3e6a04c1c" />

-->This tells Terraform: Use the AWS provider & Deploy resources in the Mumbai (ap-south-1) region.

**Lets Understand Each Part:**

<img width="427" height="487" alt="image" src="https://github.com/user-attachments/assets/3a79a80f-20f5-4ea0-893a-082bd385056d" />

<img width="786" height="622" alt="image" src="https://github.com/user-attachments/assets/ca9a174a-5a7e-4c13-9387-5dc3785fb3b2" />

<img width="780" height="682" alt="image" src="https://github.com/user-attachments/assets/90565c5c-f12f-4ae4-9b16-2473c544b980" />

<img width="762" height="250" alt="image" src="https://github.com/user-attachments/assets/7dccd7bf-6f62-4db8-bb52-8f64c89eeaa7" />

**Why Version Pinning Matters:**

-->Without version pinning: Your Terraform code may suddenly fail after a provider upgrade. Version pinning ensures everyone uses compatible versions.

<img width="677" height="362" alt="image" src="https://github.com/user-attachments/assets/4109b43a-4643-4d76-a090-506f91d0723a" />

**Benefits:**
- Predictable deployments
- Reproducible infrastructure
- Prevents breaking changes
- Easier collaboration
- Stable CI/CD pipelines

Q. What Does ~> Mean?

--> The **~>** operator is called the pessimistic version constraint. It allows updates within a compatible version range while preventing upgrades to versions that may introduce breaking changes.

<img width="746" height="522" alt="image" src="https://github.com/user-attachments/assets/ca1cadb8-cd08-4660-a0a8-8b7677c292c4" />

<img width="722" height="451" alt="image" src="https://github.com/user-attachments/assets/248aebcc-38f2-4dfe-8387-a8a1beef5308" />

<img width="756" height="442" alt="image" src="https://github.com/user-attachments/assets/ad5e9951-2c73-425f-8d75-50771b27edf3" />

<img width="912" height="246" alt="image" src="https://github.com/user-attachments/assets/ba4493db-1f8f-4beb-b7e0-9da497e57d01" />

Bonus: Provider Alias: Sometimes you need to work with multiple configurations of the same provider, such as different AWS regions or different AWS accounts.

<img width="832" height="557" alt="image" src="https://github.com/user-attachments/assets/034ef730-7231-4ffd-966a-b4378f8d0b9b" />

-->A more practical example uses two different regions:

<img width="770" height="255" alt="image" src="https://github.com/user-attachments/assets/03ebea5e-8885-4974-a1e8-47ec5c318e2a" />

**Using the Alias:** Suppose you want an S3 bucket in Singapore. 

<img width="772" height="472" alt="image" src="https://github.com/user-attachments/assets/016120b0-a3c1-493c-bae8-fbd5fe9c271a" />

Q. When Would You Use Provider Aliases?

<img width="852" height="207" alt="image" src="https://github.com/user-attachments/assets/6fb05203-0ecc-4f3d-9a59-e5059b85578d" />

Q. Why should you pin provider versions?

--> Version pinning ensures consistent and reproducible infrastructure deployments. It prevents unexpected breaking changes when new provider versions are released, allowing all team members and CI/CD pipelines to use compatible Terraform and provider versions.

**Note:**

<img width="882" height="262" alt="image" src="https://github.com/user-attachments/assets/0fb4bbb1-79d0-4663-91e2-2c081f5e3d3e" />

**Command used:**

-->terraform init

-->terraform validate

-->terraform plan

-->terraform apply --auto-approve

<img width="1790" height="942" alt="image" src="https://github.com/user-attachments/assets/8251bda9-adcb-4d82-8ccb-c5f30e196cf8" />

<img width="1866" height="971" alt="image" src="https://github.com/user-attachments/assets/ba852a28-a912-46c4-9798-07298c298316" />

<img width="1902" height="826" alt="image" src="https://github.com/user-attachments/assets/5547501f-23c8-4fcc-aab4-290dbe47a4f5" />

<img width="1775" height="942" alt="image" src="https://github.com/user-attachments/assets/0e8d6571-838b-4863-a9de-cf8b7feffcb9" />

<img width="1832" height="947" alt="image" src="https://github.com/user-attachments/assets/552b3891-ba5f-4079-98c5-f5f940bf7414" />

<img width="1895" height="836" alt="image" src="https://github.com/user-attachments/assets/d0d18ac1-8879-4f0e-9d86-d7a0a3a10eb1" />

### Task 2: Resources vs Data Sources
- Create at least one **resource** (something new).
- Use at least one **`data`** source to *read* existing info (e.g. `aws_ami`, `aws_availability_zones`, or your default VPC).
- Explain the difference: **resources create/manage**, **data sources only read**.

-->This task teaches one of the most important Terraform concepts: 
- Resources** → Create and manage infrastructure. 
- Data Sources** → Read information about existing infrastructure without creating or modifying it.

Step 1: Provider Configuration: 

<img width="652" height="142" alt="image" src="https://github.com/user-attachments/assets/9f3ea3e4-54d3-44b4-acb3-e1b4fcae7e47" />

Step 2: Read Existing AWS Information (Data Sources): 

<img width="801" height="537" alt="image" src="https://github.com/user-attachments/assets/d4ae4b21-3efe-426d-90db-96431a1967f2" />

<img width="776" height="292" alt="image" src="https://github.com/user-attachments/assets/39dd00df-ff6c-44da-9265-d6e61d8ffe09" />

Step 3: Create a Resource: Create an S3 bucket: [Expected: This creates a brand-new S3 bucket in your AWS account.]

<img width="647" height="140" alt="image" src="https://github.com/user-attachments/assets/a3867148-b953-41a7-94dd-ac61a9caa7c0" />

-->Create Complete main.tf: vi main.tf 
<img width="772" height="455" alt="image" src="https://github.com/user-attachments/assets/16f2b52b-cbfb-47a8-b955-b82e525973e1" />

-->Create outputs.tf: vi outputs.tf

<img width="712" height="402" alt="image" src="https://github.com/user-attachments/assets/ec7048ff-f430-47c4-9695-023e98a72c7e" />

-->Run Terraform


### Task 3: Provision a Cloud Stack
Use the **AWS starter code in [`./example`](./example)** (or adapt to Azure/GCP). It builds a minimal, free-tier-friendly stack:
- a **VPC** + **public subnet** + **internet gateway** + **route table**
- a **security group**
- an **EC2 instance** using a **data source** to find the latest Amazon Linux 2023 AMI

```bash
cd example
terraform init
terraform validate
terraform plan
terraform apply      # type: yes
terraform state list # see everything Terraform now manages
```

### Task 4: Meta-Arguments in Action
Extend the config to practice each of these:
- **`count`** — create N identical resources (e.g. N EC2 instances).
- **`for_each`** — create resources from a `map`/`set` (preferred over `count` for named things).
- **`depends_on`** — force an explicit ordering.
- **`lifecycle`** — try `create_before_destroy`, `prevent_destroy`, and `ignore_changes`.

```hcl
lifecycle {
  create_before_destroy = true
  ignore_changes        = [tags["LastModified"]]
}
```

### Task 5: Update & Destroy
- Change a `tag` or the `instance_type`, run `terraform plan`, and read the diff — notice what forces **replace** vs **in-place update**.
- **Always** finish with:
```bash
terraform destroy   # type: yes  — avoid surprise bills!
```

---

> 📚 **Reference the companion repo:** study [`examples/for_each.tf`](https://github.com/LondheShubham153/terraform-for-devops/blob/main/examples/for_each.tf) (for_each maps/sets + **dynamic blocks**) and [`examples/lifecycle.tf`](https://github.com/LondheShubham153/terraform-for-devops/blob/main/examples/lifecycle.tf) (all four lifecycle patterns). The real infra in [`ec2.tf`](https://github.com/LondheShubham153/terraform-for-devops/blob/main/ec2.tf) / [`s3.tf`](https://github.com/LondheShubham153/terraform-for-devops/blob/main/s3.tf) / [`dynamodb.tf`](https://github.com/LondheShubham153/terraform-for-devops/blob/main/dynamodb.tf) shows the same concepts on live AWS.

## 🧠 `count` vs `for_each` — which one?
- Use **`count`** for N *identical, interchangeable* resources.
- Use **`for_each`** when each instance has a *stable identity* (a name/key) — deleting one won't reindex the rest.

---

## 🍫 Bonus (Brownie Points)
- Attach an Elastic IP, or add user-data to install Nginx on boot.
- Use `terraform graph` and visualize the dependency graph.
- Try the **`moved`** block to rename a resource without destroying it.

---

## 📤 What to Submit
- Blog / LinkedIn / X post: your `terraform plan`/`apply` output, the AWS console showing your resources, and the diff when you changed something.
- Push to your GitHub repo. Tag **#TrainWithShubham #TerraWeekChallenge**.

---

📺 **Companion video:** [Terraform In One Shot](https://youtu.be/S9mohJI_R34) (Project 1 — EC2, S3, DynamoDB on AWS)
💻 **Companion code:** [`ec2.tf`](https://github.com/LondheShubham153/terraform-for-devops/blob/main/ec2.tf), [`examples/for_each.tf`](https://github.com/LondheShubham153/terraform-for-devops/blob/main/examples/for_each.tf), [`examples/lifecycle.tf`](https://github.com/LondheShubham153/terraform-for-devops/blob/main/examples/lifecycle.tf) · [AWS Provider docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
💬 Questions? [Discord](https://discord.gg/hs3Pmc5F) / [Telegram](https://t.me/trainwithshubham).

### Happy Terraforming! 🌍💻
