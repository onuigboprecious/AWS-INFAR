# AWS Infrastructure as Code (Terraform)

A modular, multi-tier AWS infrastructure project managed with [Terraform](https://www.terraform.io/). This repository provisions a secure, highly available foundation tailored for multi-environment cloud deployments (development, staging, and production).

---

## Architecture Overview

```
                          Internet
                             │
                      ┌──────┴──────┐
                      │     IGW     │
                      └──────┬──────┘
                             │
     ┌───────────────────────┼────────────────────────┐
     │                       ▼                        │
     │      Public Subnet 1 (10.1.1.0/24)             │
     │      ├── Public Security Group                 │
     │      │   └── Ports 80, 443, 22                 │
     │      └── NAT Gateway (Elastic IP)              │
     │                       │                        │
     │                       ▼                        │
     │      Private Subnet 1 (10.1.3.0/24)            │
     │      ├── Private Security Group                │
     │      │   └── Inbound from Public SG only       │
     │      └── EC2 Backend Instance (t3.micro)       │
     │                                                │
     │   Static Frontend Storage:                     │
     │   └── S3 Bucket (Website Hosting Enabled)      │
     │                                                │
     │   Database Layer (Module):                     │
     │   └── RDS PostgreSQL (Multi-AZ)                │
     └────────────────────────────────────────────────┘
```

### Key Components

- **VPC & Networking**: Dedicated VPC with customizable CIDR block (`10.1.0.0/16`), split across public and private subnets in multiple Availability Zones with DNS support enabled.
- **Routing & Connectivity**:
  - **Internet Gateway (IGW)** for public ingress and direct outbound access from public subnets.
  - **NAT Gateway with Elastic IP** granting secure outbound internet access for private workloads (patching, package installations, external APIs).
- **Security Groups**:
  - **Public SG**: Ingress rules for HTTP (`80`), HTTPS (`443`), and SSH (`22`).
  - **Private SG**: Restricted inbound access limited exclusively to traffic originating from the Public SG.
- **Reusable Modules**:
  - **EC2 Module** ([`modules/Ec2`](./development/modules/Ec2)): Manages the private backend compute instance.
  - **S3 Module** ([`modules/S3`](./development/modules/S3)): Manages an S3 bucket configured for static web hosting, versioning, and website policies.
  - **RDS Module** ([`modules/Rds`](./development/modules/Rds)): Reusable configuration for Multi-AZ PostgreSQL instances with automated backups and dedicated subnet groups.

---

## Directory Structure

```text
aws-infar/
├── README.md                 # Project documentation
├── development/              # Active development environment
│   ├── main.tf               # Root module invocations (EC2, S3)
│   ├── vpc.tf                # VPC configuration
│   ├── subnet.tf             # Public and private subnets
│   ├── igw.tf                # Internet Gateway
│   ├── nat_gateway.tf        # NAT Gateway & Elastic IP
│   ├── route.tf              # Route tables & associations
│   ├── security_group.tf     # Security group firewall rules
│   ├── variable.tf           # Input variable declarations & defaults
│   ├── output.tf             # Output values (VPC ID, Subnets, EIP)
│   ├── provider.tf           # AWS provider configuration
│   ├── script.sh             # Convenience automation script
│   └── modules/              # Reusable Terraform modules
│       ├── Ec2/              # Compute instance module
│       ├── S3/               # Static web hosting S3 bucket module
│       └── Rds/              # PostgreSQL database module
├── staging/                  # Staging environment (ready for rollout)
└── production/               # Production environment (ready for rollout)
```

---

## Prerequisites

Before deploying the infrastructure, ensure you have:

1. **Terraform CLI** (>= v1.0.0) installed. Check with:
   ```bash
   terraform version
   ```
2. **AWS CLI** installed and configured with appropriate IAM permissions:
   ```bash
   aws configure
   ```
3. AWS credentials with permissions to manage VPC, EC2, S3, RDS, and IAM resources.

---

## Quickstart & Deployment

Navigate to the target environment directory (e.g., `development`):

```bash
cd development
```

### 1. Initialize Terraform

Download provider plugins and initialize local modules:

```bash
terraform init
```

### 2. Review the Execution Plan

Verify the resources that Terraform will create:

```bash
terraform plan -out=tfplan
```

### 3. Apply Infrastructure Changes

Deploy resources to AWS:

```bash
terraform apply tfplan
```

Or using the automated script:

```bash
chmod +x script.sh
./script.sh
```

### 4. Verify Outputs

Retrieve key deployment attributes:

```bash
terraform output
```

Key outputs include:
- `vpc_id`: ID of the provisioned VPC.
- `public_subnet_ids`: IDs of the public subnets.
- `private_subnet_ids`: IDs of the private subnets.
- `nat_gateway_ip`: Public Elastic IP attached to the NAT Gateway.
- `security_groups_id`: IDs of created security groups.

---

## Configuration Variables

Key variables defined in [`development/variable.tf`](./development/variable.tf):

| Variable | Description | Default |
| :--- | :--- | :--- |
| `aws_region` | AWS deployment region | `us-west-1` |
| `vpc_name` | Name prefix applied to all resources | `infars-vpc` |
| `vpc_cidr_block` | CIDR block for the VPC | `10.1.0.0/16` |
| `public_subnet_cidrs` | CIDR blocks for public subnets | `["10.1.1.0/24", "10.1.2.0/24"]` |
| `private_subnet_cidrs`| CIDR blocks for private subnets | `["10.1.3.0/24", "10.1.4.0/24"]` |
| `azs` | Availability zones for subnets | `["us-east-1a", "us-east-1b"]` |
| `instance_type` | EC2 instance sizing for backend | `t3.micro` |
| `ami_id` | AMI identifier for EC2 instance | `ami-091138d0f0d41ff90` |
| `environment` | Environment label (`dev`, `staging`, `prod`) | `development` |

---

## Clean Up (Destroy Infrastructure)

To avoid incurring ongoing AWS charges when the environment is no longer required:

```bash
terraform destroy
```
