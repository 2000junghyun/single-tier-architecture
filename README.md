# Single-tier security architecture

## Overview

This project provisions a single-tier architecture on AWS using Terraform, deploying a web application where the web server, app server, and database run on a single EC2 instance.

## Tech Stack

- Terraform (modular structure)
- AWS EC2
- Ubuntu 24.04
- Nginx + Flask + SQLite
- Shell Script (cloud-init [setup.sh](http://setup.sh/))

## Directory Structure

```
.
├── modules/
│ ├── vpc/
│ │ └── main.tf, variables.tf, outputs.tf
│ ├── security_group/
│ │ └── main.tf, variables.tf, outputs.tf
│ └── ec2/
│ ├── main.tf, variables.tf, outputs.tf
│ └── setup.sh : Installs Nginx, Flask and starts app
├── main.tf : Root Terraform config
├── variables.tf
├── outputs.tf
└── README.md
```

## How to Use
```bash
$ terraform init
$ terraform plan
$ terraform apply
```

- Make sure you have a key pair named `single-tier-key` in your AWS account
- After apply, access the instance via the public IP
- No user input is required during provisioning.
- EC2 instance setup is fully automated via `setup.sh`.

## Dispose
Remove all resources created with terraform
```bash
$ terraform destroy
```

## Features / Main Logic

- Modularized Terraform infrastructure:
    - VPC, subnet, routing
    - Security Group with SSH & HTTP rules
    - EC2 with user_data automation
- Single EC2 instance handles:
    - Nginx web server (port 80)
    - Flask application server (port 5000)
    - SQLite database (embedded)
- Automated provisioning using shell script
- Designed for test/dev environment deployments

## Motivation / Expected Impact

- Designed to understand and practice infrastructure-as-code using Terraform
- Helps simulate real-world deployment pipelines on a simplified architecture
- Lays the foundation for scaling up to multi-tier architectures in future projects
