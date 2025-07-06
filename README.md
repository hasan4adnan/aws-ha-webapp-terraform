# AWS High Availability Web Application with Terraform

This project provisions a **highly available, auto-scalable web application infrastructure** on AWS using Terraform modules. It demonstrates best practices for building resilient cloud environments with Infrastructure as Code (IaC).

## ✅ Features

* **Modular Terraform Architecture**
   * VPC with public/private subnets across multiple AZs
   * NAT Gateway for secure outbound traffic
   * Internet Gateway for public subnet access
   * Custom Security Groups for ALB, EC2, and RDS
* **Application Load Balancer (ALB)**
   * Internet-facing with HTTP listener
   * Routes traffic to healthy EC2 instances
* **Auto Scaling Group (ASG)**
   * Launch Template with user data for web server bootstrapping
   * Minimum 2 EC2 instances distributed in private subnets
   * Attached to ALB Target Group
* **Outputs**
   * ALB DNS name
   * VPC ID
   * Public & Private Subnets
   * Target Group ARN

## ⚙️ Architecture Overview

```
+-----------------------------+
|          Internet           |
+------------+----------------+
             |
      +-----v------+
      |    ALB     | <-- Application Load Balancer
      +-----+------+
             |
   +--------+---------+
   | Auto Scaling Group|
   +-------------------+
           /     \
+--------+------+ +--------+------+
| EC2 Instance  | | EC2 Instance  | <-- In Private Subnets
+---------------+ +---------------+
```

## 🚀 Technologies Used

* **Terraform v1.x**
* **AWS Provider**
* Modules: `VPC`, `Security Groups`, `ALB`, `Compute`

## 📂 Project Structure

```
.
├── main.tf
├── variables.tf
├── outputs.tf
├── modules/
│   ├── vpc/
│   ├── security_groups/
│   ├── alb/
│   └── compute/
└── userdata.sh
```

* `main.tf`: Root module calling child modules with input variables
* `modules/`: Reusable module definitions for each infrastructure component
* `userdata.sh`: Bootstraps EC2 with a basic web server

## 🗝️ Prerequisites

* AWS Account with sufficient IAM permissions
* AWS CLI configured (`aws configure`)
* Terraform installed locally

## 🔑 Input Variables

Example inputs:

| Variable | Description | Example |
|----------|-------------|---------|
| `ami_id` | AMI ID for EC2 instances | `ami-05ffe3c48a9991133` |
| `instance_type` | EC2 instance type | `t3.micro` |
| `key_name` | Name of your EC2 key pair | `ec2-tutorial` |
| `project_name` | Project resource name prefix | `aws-ha-webapp` |

## ⚡️ How to Deploy

### 1️⃣ Initialize Terraform

```bash
terraform init
```

### 2️⃣ Review the Execution Plan

```bash
terraform plan
```

### 3️⃣ Apply the Configuration

```bash
terraform apply
```

When prompted, type `yes` to confirm.

## 🌐 Verify

After deployment, get your ALB DNS:

```bash
terraform output alb_dns_name
```

Visit `http://<ALB_DNS>` to see your test web app served by your EC2 instances!

## 🔒 Security Groups

| SG | Ingress | Egress |
|----|---------|--------|
| ALB SG | HTTP(80)/HTTPS(443) from 0.0.0.0/0 | All outbound |
| EC2 SG | HTTP(80) from ALB SG only | All outbound |
| RDS SG (sample) | MySQL(3306) from EC2 SG only | All outbound |

## 🚨 Important Notes

* **AMI**: Ensure you use a valid Amazon Linux 2 or your custom AMI.
* **NAT Gateway**: This incurs costs; shut down when not needed.
* **User Data**: Adjust `userdata.sh` to match your web app needs.
* **SSH Access**: EC2 instances are in private subnets; use a bastion or SSM if needed.


## 🔄 Destroy

When done, destroy the infrastructure:

```bash
terraform destroy
```

## 🏷️ Outputs

Example output:

```bash
alb_dns_name = "aws-ha-webapp-alb-xxxxxx.us-east-1.elb.amazonaws.com"
vpc_id = "vpc-xxxxxxxxxxxxxxxxx"
private_subnets = [
  "subnet-xxxx",
  "subnet-yyyy"
]
public_subnets = [
  "subnet-aaaa",
  "subnet-bbbb"
]
target_group_arn = "arn:aws:elasticloadbalancing:..."
```

## 📚 License

This project is for demonstration and educational purposes. Use at your own risk!

## 🙌 Author

Built using Terraform, by Hasan Adnan
