# 🧩 TerraWeek Day 2 — HCL Deep Dive: Variables, Types & Expressions

**Date:** Monday, 13th July 2026

Yesterday you ran your first `apply`. Today you'll learn the **language** behind it — **HCL (HashiCorp Configuration Language)** — so your configs become flexible, reusable, and readable. ✍️

---

## 🎯 Learning Goals

- Understand HCL **blocks, arguments, and expressions**.
- Use **input variables** with types, defaults, validation, and `sensitive`.
- Use **`locals`**, **`outputs`**, and built-in **functions**.
- Understand **variable precedence** (`tfvars`, `-var`, env vars).

---

## 📝 Tasks

### Task 1: Master HCL Syntax
Explain (with examples) in your notes:
- The anatomy of a **block**: `block_type "label_one" "label_two" { argument = value }`.
- The difference between an **argument** and a **block**.
- **Expressions**: string interpolation `"${...}"`, references (`resource.name.attr`), and operators.

**Steps to follow:**

-->Great! This task is about understanding HashiCorp Configuration Language (HCL), which is the language Terraform uses.

Task 1: Master HCL Syntax: 

Q. What is HCL?

-->HashiCorp Configuration Language (HCL) is a human-readable configuration language used by Terraform to define infrastructure. Instead of writing long scripts, you describe what you want, and Terraform figures out how to create it.

<img width="737" height="282" alt="image" src="https://github.com/user-attachments/assets/ef905f65-e3fa-4c9d-a03c-5b9e64565c5e" />

**1. The Anatomy of an HCL Block: Almost everything in Terraform is written inside blocks.**

<img width="712" height="420" alt="image" src="https://github.com/user-attachments/assets/67effeb0-a40b-46a1-b69a-f059604f0e40" />

**Breakdown:**

<img width="687" height="752" alt="image" src="https://github.com/user-attachments/assets/029bd4bc-0d2a-4614-8686-939d6f384741" />
<img width="697" height="520" alt="image" src="https://github.com/user-attachments/assets/53e9a11a-450e-41e1-a112-0bfd4d9efdc0" />

<img width="735" height="822" alt="image" src="https://github.com/user-attachments/assets/9c111d5c-e4ac-474b-b817-f575892072b2" />
<img width="591" height="352" alt="image" src="https://github.com/user-attachments/assets/b11b6c61-5395-42c6-bf44-353b50a8019a" />

**2. Difference Between an Argument and a Block: ** This is one of the most important concepts in HCL.

**Argument:** Arguments assign a single value to a configuration setting.

<img width="707" height="657" alt="image" src="https://github.com/user-attachments/assets/5eab239a-4c6d-4418-a086-1c510ab993a5" />

**Blocks:** Blocks define a nested configuration. They contain one or more arguments (and sometimes additional nested blocks).

<img width="702" height="577" alt="image" src="https://github.com/user-attachments/assets/8b6ef977-7855-4c3f-94f8-0431640da836" />

<img width="687" height="492" alt="image" src="https://github.com/user-attachments/assets/4a177d14-8ead-4ba1-bf9f-53ac0070f836" />

**Quick comparison table:**

<img width="672" height="217" alt="image" src="https://github.com/user-attachments/assets/f9a82380-7f11-41e2-9bb8-0aa5dbb3b283" />

3. **Expressions**: string interpolation `"${...}"`, references (`resource.name.attr`), and operators.

-->**Expressions:** Expressions allow Terraform to calculate values instead of hardcoding them: Terraform supports: Literal values, References, Interpolation
Functions, Operators, Conditionals etc.

**A. String Interpolation:** Terraform can insert values inside strings using: "${ ... }"

<img width="732" height="707" alt="image" src="https://github.com/user-attachments/assets/e2ce5fcd-4d5a-4074-8314-1fa9f84d50d1" />

-->Modern Terraform also allows direct interpolation in many places:

<img width="672" height="136" alt="image" src="https://github.com/user-attachments/assets/af6d8da7-d0b0-4f1f-8a62-4b46e7f982b5" />

**B. References:** Resources can refer to other resources: General syntax: resource_type.resource_name.attribute

<img width="707" height="817" alt="image" src="https://github.com/user-attachments/assets/d21ba0b9-4d51-4daf-a4da-408157e120f0" />
<img width="712" height="242" alt="image" src="https://github.com/user-attachments/assets/92f95565-6caa-4797-9b28-349c9ff889e0" />

**C. Operators:** Terraform supports arithmetic, comparison, and logical operators.

**1. Arithmetic Operator:** 

**2. Comparison operator:**

<img width="577" height="775" alt="image" src="https://github.com/user-attachments/assets/116d5700-f366-483b-b34a-e32ef258420e" />

**3. Logical Operator:** 

<img width="602" height="810" alt="image" src="https://github.com/user-attachments/assets/bc99ea0f-35f5-4cbc-bc6c-8b7e8341b7ee" />

<img width="607" height="167" alt="image" src="https://github.com/user-attachments/assets/3c68797e-0ce2-4551-9793-02bda93faede" />

**Summary:**

<img width="777" height="652" alt="image" src="https://github.com/user-attachments/assets/dd1c26ff-545b-42c4-8c95-150ff7ff4194" />

### Task 2: Variables, Types & Validation
Create a `variables.tf` and define variables covering **each major type**:
- Primitives: `string`, `number`, `bool`
- Collections: `list(string)`, `map(string)`, `set(string)`
- Structural: `object({...})`, `tuple([...])`

Add at least one variable with:
- a **`default`**,
- a **`validation`** block (e.g. only allow certain values),
- the **`sensitive = true`** flag.

```hcl
variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod."
  }
}
```
**Steps to follow:**

-->This task is designed to help you understand Terraform variables, their types, and how to make your configurations safer using defaults, validation, and sensitive values.

Q. What are Terraform Variables?

-->Variables allow you to make your Terraform configurations dynamic and reusable. Instead of hardcoding values, you can define them as variables and provide different values for different environments.
<img width="682" height="335" alt="image" src="https://github.com/user-attachments/assets/574770ed-f656-451b-8e54-7e93b188bf52" />









### Task 3: Locals, Outputs & Functions
- Use a **`locals`** block to compute a value (e.g. a common `name_prefix` or merged tags).
- Add **`outputs`** that expose useful values.
- Use at least **3 built-in functions** — e.g. `upper()`, `merge()`, `join()`, `lookup()`, `length()`, `format()`.
  Explore them live with `terraform console`:
```bash
terraform console
> upper("terraweek")
> merge({a=1}, {b=2})
> join("-", ["tws", "terraweek", "2026"])
```

### Task 4: Build Something Real (Docker provider — no cloud cost)
Use the **starter code in [`./example`](./example)**. It uses the **`kreuzwerker/docker`** provider to pull an Nginx image and run a container — fully driven by variables.

> 🐳 **Prereq:** Docker installed and running. Prefer cloud? Swap the Docker resources for a `local_file` driven by your variables — the HCL concepts are identical.

```bash
cd example
terraform init
terraform plan  -var 'container_name=tws-web' -var 'external_port=8080'
terraform apply -var 'container_name=tws-web' -var 'external_port=8080'
# visit http://localhost:8080
terraform output
terraform destroy -var 'container_name=tws-web' -var 'external_port=8080'
```

Then try the same run using a **`terraform.tfvars`** file instead of `-var` flags and note the difference.

---

## 📊 Variable Precedence (highest wins)
```
-var / -var-file  ▶  *.auto.tfvars  ▶  terraform.tfvars  ▶  TF_VAR_ env vars  ▶  default
```

---

## 🍫 Bonus (Brownie Points)
- Add a **`for` expression** to transform a list/map (e.g. `[for s in var.names : upper(s)]`).
- Use a **conditional expression**: `var.environment == "prod" ? "t3.medium" : "t3.micro"`.
- Try **`optional()`** attributes inside an `object` type.

---

## 📤 What to Submit
- Blog / LinkedIn / X post: your `variables.tf`, a `terraform console` screenshot, and your running container/output.
- Push to your GitHub repo. Tag **#TrainWithShubham #TerraWeekChallenge**.

---

📺 **Companion video:** [Terraform In One Shot](https://youtu.be/S9mohJI_R34) (HCL, variables & validation)
💻 **Companion code:** [`examples/validation.tf`](https://github.com/LondheShubham153/terraform-for-devops/blob/main/examples/validation.tf) — 5 real validation patterns · [Config Language docs](https://developer.hashicorp.com/terraform/language)
💬 Questions? [Discord](https://discord.gg/hs3Pmc5F) / [Telegram](https://t.me/trainwithshubham).

### Happy Terraforming! 🌍💻
