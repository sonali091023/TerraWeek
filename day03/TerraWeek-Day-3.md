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
- **Resources** → Create and manage infrastructure. 
- **Data Sources** → Read information about existing infrastructure without creating or modifying it.

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

**Run Terraform:**

-->initilise terraform: terraform init

-->Preview changes: terraform plan

-->terraform apply: terraform apply

<img width="867" height="392" alt="image" src="https://github.com/user-attachments/assets/fad9f7d8-5cd6-48ad-9ca2-704374af7bfc" />

**Visual Understanding:**

<img width="627" height="805" alt="image" src="https://github.com/user-attachments/assets/eb8d61c8-815a-4204-a376-f9e5c576855e" />

**Note:**
- Resources create, update, and delete infrastructure that Terraform manages in its state. Examples include S3 buckets, EC2 instances, and VPCs.
- Data sources only read information about existing infrastructure or provider metadata. They never create or modify resources. Examples include Availability Zones, AMIs, and the default VPC.

In this task, I used:
- resource "aws_s3_bucket" to create a new S3 bucket.
- data "aws_availability_zones" and data "aws_vpc" to read existing AWS information without making any changes.

**Command used:**
- terraform init
- terraform validate
- terraform plan
- terraform apply --auto-approve

<img width="1846" height="942" alt="image" src="https://github.com/user-attachments/assets/94801494-defe-4743-97ef-de065694af1d" />
<img width="1837" height="935" alt="image" src="https://github.com/user-attachments/assets/bf99b61d-d038-4e5b-ad93-be264c416e57" />
<img width="1802" height="947" alt="image" src="https://github.com/user-attachments/assets/2a18635c-4e0c-469e-8c5a-ea2849784534" />
<img width="1905" height="876" alt="image" src="https://github.com/user-attachments/assets/95817581-7159-4bc2-910e-9df92ef5ef01" />
<img width="1835" height="977" alt="image" src="https://github.com/user-attachments/assets/cf51d73a-6229-4434-966a-ecb1246fa747" />

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

**Steps to follow:**

**Provision a Cloud Stack Architecture:**

<img width="837" height="541" alt="image" src="https://github.com/user-attachments/assets/897bcb47-fe57-4463-a4ad-aa823117ab0e" />

Step 1: Provider: vi provider.tf

<img width="487" height="150" alt="image" src="https://github.com/user-attachments/assets/574538fe-d260-4f2a-a7b6-7cee0dc1e6b0" />

Step 2: Variables: vi variable.stf

<img width="766" height="467" alt="image" src="https://github.com/user-attachments/assets/d7648006-cac1-48c2-9fc2-344e3e4049d8" />

Step 3: Create the Network: Create VPC

<img width="790" height="287" alt="image" src="https://github.com/user-attachments/assets/8c4c86cc-2b98-4f62-82d1-7c3ad06f325e" />

-->Create Public Subnet: 

<img width="842" height="362" alt="image" src="https://github.com/user-attachments/assets/089d37b7-cd46-49f8-9095-98cc5480a7d0" />

-->Create Internet Gateway: 

<img width="825" height="285" alt="image" src="https://github.com/user-attachments/assets/72d4c617-ab2b-4666-906c-c4ed386e8d0c" />

-->Create Route Table

<img width="807" height="382" alt="image" src="https://github.com/user-attachments/assets/bb0349f9-3aac-4c92-aca7-76f440a80a0f" />

-->Route Table Association: 

<img width="747" height="172" alt="image" src="https://github.com/user-attachments/assets/cdbc4e7a-cd93-4706-8511-8b74cb55aef4" />

Step 4: Security Group: 

<img width="736" height="787" alt="image" src="https://github.com/user-attachments/assets/a34b2e2f-9bff-4718-971e-9fddd964090c" />

Step 5: Data Source (Latest Amazon Linux 2023 AMI): This satisfies the assignment requirement of using a data source.

-->Terraform queries AWS and automatically selects the latest Amazon Linux 2023 AMI.

<img width="721" height="411" alt="image" src="https://github.com/user-attachments/assets/24ffe031-0bdf-48f9-b59b-dca850ef67e5" />

Step 6: EC2 Instance: 

-->Notice the line: The AMI is read from the data source, not hardcoded.

<img width="747" height="497" alt="image" src="https://github.com/user-attachments/assets/2a0b407f-6c3e-4943-9ff1-5d0321243ca1" />

Step 7: Outputs: 

<img width="780" height="501" alt="image" src="https://github.com/user-attachments/assets/ce195d23-98fd-4313-bd8b-e8a31b713ca8" />

**Run Terraform:**

-->terraform init

-->terraform validate

-->terraform plan

-->terraform apply --auto-approve

-->terraform destroy

Expected Resources: After terraform apply, your AWS account should contain:

<img width="892" height="367" alt="image" src="https://github.com/user-attachments/assets/b6543305-bb3f-4daf-acf5-ae2b6e47f09d" />

<img width="767" height="440" alt="image" src="https://github.com/user-attachments/assets/d5c68a8c-7031-436f-b0a5-ff74cafd95ae" />

<img width="1857" height="937" alt="image" src="https://github.com/user-attachments/assets/698278db-a3ec-4385-a576-e2c2359c8166" />

<img width="1852" height="982" alt="image" src="https://github.com/user-attachments/assets/94fb8619-133f-469a-ad01-3ab60af834ac" />

<img width="1857" height="952" alt="image" src="https://github.com/user-attachments/assets/5aea3dfd-62f4-4988-9b47-964b0fb9198b" />

<img width="1860" height="950" alt="image" src="https://github.com/user-attachments/assets/47465f89-771d-4905-85dd-d95bc8b4e8c1" />

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

**Steps to follow:**

-->This task is designed to teach Terraform meta-arguments—special arguments that control how resources are created and managed, rather than what they create.

**Meta-Arguments in Action:**
- count
- for_each
- depends_on
- lifecycle

1. count — Create Multiple Identical Resources: Use count when you want multiple identical resources.

Example: Launch 2 EC2 instances:

-->Add variable in varaibles.tf file: vi variables.tf

-->Update your EC2 resource: vi main.tf

<img width="687" height="832" alt="image" src="https://github.com/user-attachments/assets/0f57fd32-aa37-44d7-8e62-82d07e2f1641" />

2. for_each — Create Named Resources: for_each is better than count when each resource has its own identity.

Create multiple S3 buckets: 

-->Add variable in varaibles.tf file: vi variables.tf

-->Update your s3 bucket resource: vi main.tf

<img width="721" height="685" alt="image" src="https://github.com/user-attachments/assets/400d8df5-1543-4b6c-9a9f-3788b7e66b37" />
<img width="742" height="357" alt="image" src="https://github.com/user-attachments/assets/e218070d-5fe1-4e00-a635-76cf2f09da42" />

**Note:** We prefer for_each because If we remove one bucket name: bucket2, Terraform only removes bucket2, But with count, removing the middle element can shift indexes and cause unnecessary replacements.

3. depends_on — Explicit Dependency: Terraform usually infers dependencies from references.

<img width="717" height="612" alt="image" src="https://github.com/user-attachments/assets/5bb3895d-7fd8-40e4-8bfc-12b00f5dffdf" />
<img width="690" height="306" alt="image" src="https://github.com/user-attachments/assets/d6e3bc10-b943-487c-a9d4-320031b8272e" />

4. lifecycle: The lifecycle block changes how Terraform manages resources.
<img width="641" height="741" alt="image" src="https://github.com/user-attachments/assets/c7a4dac2-6e54-499a-b703-fcc7f7ddeb7c" />
<img width="742" height="437" alt="image" src="https://github.com/user-attachments/assets/655caeb6-89b3-4279-b27e-0563cf40f59b" />
<img width="705" height="600" alt="image" src="https://github.com/user-attachments/assets/54c1b694-c36a-47bb-aadb-2db6d40eed40" />

Complete Example:
<img width="701" height="561" alt="image" src="https://github.com/user-attachments/assets/553bf886-2e53-40e1-8328-eeaaf286a7d3" />

Assignment Summary:
<img width="1037" height="462" alt="image" src="https://github.com/user-attachments/assets/164760d6-9197-44a5-9606-c207592a7226" />

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
