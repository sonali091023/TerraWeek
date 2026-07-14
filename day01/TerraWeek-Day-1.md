# 🌱 TerraWeek Day 1 — Introduction to IaC & Terraform Basics

**Date:** Sunday, 12th July 2026

Welcome to **Day 1** of the TerraWeek Challenge! Today is all about **foundations** — understanding *why* Infrastructure as Code exists, installing the **latest Terraform (v1.15.x)**, and running your very first `terraform apply`. 🚀

---

## 🎯 Learning Goals

By the end of today you should be able to:
- Explain what **Infrastructure as Code (IaC)** is and why it matters.
- Describe what **Terraform** is and how it fits into the DevOps workflow.
- Install Terraform and verify it works.
- Understand the **core Terraform workflow** and key terminology.
- Provision your **first resource** — with zero cloud cost.

---

## 📝 Tasks

### Task 1: Understand IaC & Terraform
Write short answers (in your blog/notes) to:
- What is **Infrastructure as Code**, and what problems does it solve compared to clicking around a cloud console?
- What is **Terraform**, and why is it so popular? (Hint: declarative, provider-agnostic, huge ecosystem.)
- **Terraform vs alternatives** — write one line each on how Terraform compares to **OpenTofu**, **Pulumi**, **CloudFormation**, and **Ansible**.

**Steps to follow:**

**1. What is Infrastructure as Code (IaC), and what problems does it solve compared to clicking around a cloud console?**

-->Infrastructure as Code (IaC) is the practice of defining and managing infrastructure (servers, networks, databases, Kubernetes clusters, storage, etc.) using code instead of manually configuring resources through a cloud provider's web console.

<img width="766" height="787" alt="t1i1" src="https://github.com/user-attachments/assets/2fb95206-0979-4658-a99e-fddd6ebf1dd5" />

**2. What is Terraform, and why is it so popular?**

-->Terraform is an open-source Infrastructure as Code (IaC) tool developed by HashiCorp. It allows you to define cloud and infrastructure resources using a simple configuration language called HCL (HashiCorp Configuration Language).

-->Terraform reads your configuration files, determines what needs to change, and creates, updates, or deletes infrastructure to match the desired state.

**Q. Why is Terraform so popular?**

**1. Declarative Approach:** You describe what infrastructure you want, not how to create it, And Terraform figures out the steps required to create the EC2 instance.

<img width="627" height="182" alt="t1i2" src="https://github.com/user-attachments/assets/7250a3bf-405c-4cab-acc8-31d2d7f6a230" />

**2. Provider-Agnostic:** Terraform works with many platforms using providers, such as:
<img width="787" height="212" alt="t1i3" src="https://github.com/user-attachments/assets/719db49a-1f3b-4c01-b900-cb0802820c95" />

-->This means you can manage multi-cloud environments with a single tool.

**3. Huge Ecosystem:** Terraform has thousands of community and official providers and reusable modules.
<img width="916" height="172" alt="t1i4" src="https://github.com/user-attachments/assets/9e07cff6-4abe-44df-8dd5-2f9a85f4ee7d" />

**4. Execution Plan:** Before making any changes, Terraform shows exactly what it plans to do using: **terraform plan** This allows you to review changes before applying them.

**5. State Management:** Terraform keeps track of infrastructure in a state file (terraform.tfstate), enabling it to understand existing resources and apply only the necessary changes.

**6. Reusability:** You can organize infrastructure into reusable modules, reducing duplication and making large deployments easier to maintain.

**3. Terraform vs alternatives — write one line each on how Terraform compares to OpenTofu, Pulumi, CloudFormation, and Ansible.**

<img width="937" height="382" alt="t1i5" src="https://github.com/user-attachments/assets/f30df8f0-8c1d-45cb-bfef-c0b968da7279" />

**Quick Revision:**

<img width="862" height="347" alt="t1i6" src="https://github.com/user-attachments/assets/97f97dcb-25d9-4cd1-9a32-b686fdeb2c1e" />

### Task 2: Install Terraform (latest version)
- Install **Terraform ≥ 1.15** using the [official install guide](https://developer.hashicorp.com/terraform/install).
- Verify your install and **paste the output** in your notes:

```bash
terraform version
terraform -help
```
- Install the **HashiCorp Terraform** extension in VS Code for syntax highlighting and autocomplete.

**Steps to follow:**

Step 1: Check if Terraform is already installed: terraform version: 

Step 2: Install Terraform on Ubuntu (Official HashiCorp APT Repository)

-->First, update your package list and install the required tools: sudo apt update

-->sudo apt install -y gnupg software-properties-common curl

-->Add the official HashiCorp GPG key: curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

-->Add the official HashiCorp repository: echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

-->Update the package index: sudo apt update

-->Now install terraform: sudo apt install terraform [Expected: This installs the latest version available from the official HashiCorp repository.]

Step 3: Verify the Installation: terraform version

<img width="1062" height="667" alt="image" src="https://github.com/user-attachments/assets/854c1617-3ae1-42d8-8e1c-ae6aebaddba4" />

-->We can also confirm terraform install or not by running command: terraform -help

<img width="591" height="355" alt="t2i1" src="https://github.com/user-attachments/assets/301c43ad-a88e-4f19-aea6-b907b366b493" />

<img width="1110" height="720" alt="image" src="https://github.com/user-attachments/assets/3d96a2f2-1ac3-4208-bb98-5865f5f0c07e" />

Step 4: Install the VS Code Extension: HashiCorp Terraform

<img width="700" height="377" alt="t2i2" src="https://github.com/user-attachments/assets/6232eb42-2596-4fd5-9f6e-5ebe842c8383" />

Step 5: Verify the VS Code Extension:

-->Create folder and go inside it: mkdir terraform-demo && cd terraform-demo

-->Create file: touch main.tf & write the following code into the file,

<img width="540" height="252" alt="image" src="https://github.com/user-attachments/assets/53a2c550-c15b-4c6d-9e85-454568c7e09c" />

<img width="932" height="486" alt="image" src="https://github.com/user-attachments/assets/c1f65371-d977-4e5a-b77c-5cda600b0a9a" />

### Task 3: Learn 6 Crucial Terraform Terminologies
Explain each of these **in your own words** with a one-line example:
1. **Provider** — a plugin that lets Terraform talk to a platform (AWS, Azure, Docker…).
2. **Resource** — a piece of infrastructure you want to create (an EC2 instance, an S3 bucket…).
3. **State** — Terraform's record of what it manages (the `terraform.tfstate` file).
4. **Plan** — a preview of the changes Terraform will make.
5. **HCL** — HashiCorp Configuration Language, the syntax you write Terraform in.
6. **Module** — a reusable, packaged group of Terraform configuration.

**Steps to follow:**

**1. Provider:** A Provider is a plugin that enables Terraform to communicate with a specific platform or service, such as AWS, Azure, Google Cloud, Docker, or Kubernetes. It translates your Terraform configuration into API calls that create, update, or delete resources on that platform.

<img width="596" height="167" alt="t2i3" src="https://github.com/user-attachments/assets/eb99e6f3-52b3-4f6e-89b5-9a561b0ff5c8" />

**Explanation:** This tells Terraform to use the AWS provider and create resources in the Mumbai (ap-south-1) region.

**2. Resource:** A Resource is any infrastructure component that Terraform creates and manages, such as a virtual machine, storage bucket, database, or Kubernetes cluster.

<img width="665" height="131" alt="t2i4" src="https://github.com/user-attachments/assets/79d84c1b-4317-4a62-a51a-4bdb8481a230" />

**Explanation:** This creates an Amazon S3 bucket named my_bucket.

**3. State:** State is Terraform's record of the infrastructure it manages. It is stored in the terraform.tfstate file and helps Terraform determine what already exists so it can make only the necessary changes.

<img width="560" height="87" alt="t2i5" src="https://github.com/user-attachments/assets/d9e02539-387f-436b-99f0-05d7334d5501" />

**Explanation:** After creating an EC2 instance, Terraform saves its details (such as its ID and configuration) in the state file so it knows that instance already exists.

**4. Plan:** A Plan is a preview of the changes Terraform will make before modifying your infrastructure. It lets you review additions, updates, or deletions before applying them.

<img width="476" height="127" alt="t2i6" src="https://github.com/user-attachments/assets/3a1b92e2-d716-405a-963e-4e9cdf7c2a37" />

**Explanation:** This command shows what Terraform intends to create, modify, or destroy without making any actual changes.

**5. HCL (HashiCorp Configuration Language):** HCL is the human-readable language used to write Terraform configuration files. It allows you to describe your desired infrastructure in a clear and declarative way.

<img width="442" height="126" alt="t2i7" src="https://github.com/user-attachments/assets/f66bfb8a-2c27-4230-a42e-384db961a959" />

**Explanation:** This HCL statement specifies that the EC2 instance should use the t2.micro instance type.

**6. Module:** A Module is a reusable collection of Terraform configuration files that packages related resources together. Modules help reduce code duplication and make infrastructure easier to maintain.

<img width="617" height="166" alt="t2i8" src="https://github.com/user-attachments/assets/0525516c-051c-460c-8b8f-7265e86e285b" />

**Explanation:** This uses a reusable VPC module located in the modules/vpc directory.

**Quick Revision Table:**

<img width="837" height="432" alt="t2i9" src="https://github.com/user-attachments/assets/1018a783-53e4-4845-908a-b2c67e021959" />

Q. What is the relationship between Provider, Resource, State, Plan, and Module?
-->A Provider connects Terraform to a platform (like AWS). A Resource defines the infrastructure to create (such as an EC2 instance). You write these definitions
in HCL. Before making changes, Terraform generates a Plan to preview what will happen. After applying the changes, it records the infrastructure in the State file. 
To avoid repeating code, related resources can be grouped into reusable Modules.

### Task 4: Your First Terraform Config (no cloud account needed!)
Use the **starter code in [`./example`](./example)** — it uses the `local` and `random` providers, so it costs **nothing** and needs **no credentials**.

Run the **core Terraform workflow** and capture the output of each step:
```bash
cd example
terraform init      # download providers, initialize the working directory
terraform fmt       # format your code
terraform validate  # check for syntax errors
terraform plan      # preview what will be created
terraform apply     # create the resources (type: yes)
cat greeting.txt    # see the file Terraform generated
terraform destroy   # clean up (type: yes)
```

**Steps to follow:** 

-->This task is designed to help you understand the Terraform workflow without using AWS or any other cloud provider. The configuration uses the local and random providers, so everything runs on your own machine.

Step 1: Navigate to the Example Directory: Go to the directory containing the starter code: cd example then do ls inside

Step 2: Initialize Terraform: terraform init

<img width="735" height="557" alt="t4i1" src="https://github.com/user-attachments/assets/b3b7fb7e-4d32-4aec-acb7-a51800ff3c99" />

Step 3: Format the Code: terraform fmt

<img width="727" height="262" alt="t4i2" src="https://github.com/user-attachments/assets/280d180a-eb6e-482d-b346-11a1e650d4e7" />

Step 4: Validate the Configuration: terraform validate

<img width="701" height="332" alt="t4i3" src="https://github.com/user-attachments/assets/384f91e7-01b5-47a0-a7aa-99b5a6f5084b" />

Step 5: Preview the Changes: terraform plan

<img width="695" height="527" alt="t4i4" src="https://github.com/user-attachments/assets/c8954627-f2bc-423a-a39c-5f84ebba0557" />

Step 6: Apply the Configuration: terraform apply

<img width="702" height="465" alt="t4i5" src="https://github.com/user-attachments/assets/3f144149-8846-49b8-80b9-4625ef5a6f90" />

Step 7: View the Generated File: cat greeting.txt

<img width="712" height="162" alt="t4i6" src="https://github.com/user-attachments/assets/6861aefe-eecb-4211-9c7b-fbe8938031c1" />

Step 8: Destroy the Resources: terraform destroy

<img width="731" height="456" alt="t4i7" src="https://github.com/user-attachments/assets/874fa656-f3ff-40ce-ac50-1229e2f678b2" />

**Files Created During the Workflow:** After completing the task, you'll notice several new files and directories:

<img width="802" height="286" alt="t4i8" src="https://github.com/user-attachments/assets/f3c95940-194d-4081-bd70-32c348eadb14" />

**Terraform Workflow Summary:**

<img width="857" height="372" alt="t4i9" src="https://github.com/user-attachments/assets/30b96566-cb39-4263-87ae-27b4c458efdc" />

<img width="1857" height="956" alt="image" src="https://github.com/user-attachments/assets/9f8fa9f3-a726-4955-a8b7-a766a0cd6da7" />
<img width="1797" height="960" alt="image" src="https://github.com/user-attachments/assets/b8c5b92c-89e1-4370-8a3c-7563913a011e" />
<img width="1835" height="977" alt="image" src="https://github.com/user-attachments/assets/0126fe92-ed3b-4348-8db7-e74fa42d8837" />
<img width="1865" height="970" alt="image" src="https://github.com/user-attachments/assets/4514f2c3-8bf0-4c05-9277-a322e48d6bbe" />
<img width="1857" height="950" alt="image" src="https://github.com/user-attachments/assets/d7e0d694-2e0d-417c-86da-cac4a2b8faab" />

---

## 🔁 The Core Terraform Workflow

```
  Write  ──▶  Init  ──▶  Plan  ──▶  Apply  ──▶  Destroy
  (.tf)     (init)     (preview)   (create)    (clean up)
```

---

## 🍫 Bonus (Brownie Points)
- Set up **tab completion** for the Terraform CLI: `terraform -install-autocomplete`.
- Try **[OpenTofu](https://opentofu.org/)** (the open-source fork) and note the differences.
- Explore the `.terraform.lock.hcl` lock file that gets created — what is it for?

---

## 📤 What to Submit
- A blog / LinkedIn / X post with your learnings + screenshots of `terraform version` and a successful `apply`/`destroy`.
- Push your code to your own **GitHub repo**.
- Tag **#TrainWithShubham #TerraWeekChallenge** and share with your network.

---

📺 **Companion video:** [Terraform In One Shot](https://youtu.be/S9mohJI_R34) (watch the intro + install section)
💻 **Companion code:** [terraform-for-devops](https://github.com/LondheShubham153/terraform-for-devops) — start with its [README](https://github.com/LondheShubham153/terraform-for-devops#readme)
💬 Stuck? Ask in the [Discord](https://discord.gg/hs3Pmc5F) / [Telegram](https://t.me/trainwithshubham) community.

### Happy Terraforming! 🌍💻
