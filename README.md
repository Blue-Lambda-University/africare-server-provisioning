# EC2 Provisioning with Terraform and Configuration with Ansible

This project automates the provisioning of an AWS EC2 instance using **Terraform** and configures the instance using **Ansible**.

---

## Features

* Provisions an EC2 instance using Terraform
* Installs:

  * OpenJDK 17
  * Docker & Docker Compose
  * AWS CLI
* Uses Ansible for post-provision configuration

---

## Prerequisites

* [Terraform](https://developer.hashicorp.com/terraform/downloads)
* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
* An AWS Key Pair (`.pem` file) with SSH access

---

## Project Structure

```
.
├── ansible/
│   ├── inventory.ini           # Ansible inventory (generated dynamically)
│   └── playbook.yml            # Installs Java, Docker, Compose, AWS CLI
├── terraform/
│   ├── main.tf                 # EC2 provisioning code
│   ├── variables.tf            # Input variables
│   └── terraform.tfvars        # Your environment-specific values
├── setup.sh                    # Script to run Terraform and Ansible
└── README.md
```

---

## Usage

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/ec2-terraform-ansible-setup.git
cd ec2-terraform-ansible-setup
```

### 2. Edit Terraform Variables

Edit `terraform/terraform.tfvars`:

```hcl
region        = "us-east-1"
vpc_id        = "vpc-xxxxxxxx"
subnet_id     = "subnet-xxxxxxxx"
key_name      = "your-key-name"
private_key   = "./your-key.pem"
instance_type = "t3.micro"
```

>️ Make sure your private key file has the correct permissions: `chmod 400 your-key.pem`

---

### 3. Run the Setup Script

```bash
./setup.sh
```

This will:

* Deploy the EC2 instance with Terraform
* Capture the public IP
* Generate an Ansible inventory
* Run the Ansible playbook to install software

---

## Installed Software

* **OpenJDK 17**
* **Docker**
* **Docker Compose**
* **AWS CLI**

---

## Clean Up

To tear down everything:

```bash
cd terraform
terraform destroy -auto-approve
```

---

## Security Best Practices

* Do **not** commit your private key (`.pem`) to version control
* Use secure security group rules (don't expose SSH to `0.0.0.0/0` in production)
* Use Ansible Vault or AWS Secrets Manager for sensitive variables

---

## Author

Created and maintained by **Adaramola Omolewa**
[GitHub Profile](https://github.com/your-username)

---

## License

This project is licensed under the MIT License.

