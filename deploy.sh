#!/bin/bash

set -e

TF_DIR="./terraform"
ANSIBLE_DIR="./ansible"
TF_VAR_FILE="terraform.tfvars"
KEY_PATH="~/.ssh/id_rsa"

echo "👉 Running Terraform to provision EC2..."
cd "$TF_DIR"
terraform init
terraform apply -var-file="$TF_VAR_FILE" -auto-approve

echo "Terraform provisioning complete."

echo "Fetching public IP of the EC2 instance..."
EC2_IP=$(terraform output -raw public_ip)
EC2_PEM=$(terraform output -raw public_key_path)

cd -

echo "Running Ansible to configure the EC2 instance..."
ANSIBLE_HOSTS_FILE="$ANSIBLE_DIR/inventory.ini"

cat > "$ANSIBLE_HOSTS_FILE" <<EOF
[ec2]
$EC2_IP ansible_user=ubuntu ansible_ssh_private_key_file=$KEY_PATH ansible_ssh_common_args='-o StrictHostKeyChecking=no'
EOF

ansible-playbook -i "$ANSIBLE_HOSTS_FILE" "$ANSIBLE_DIR/playbook.yml"

echo "EC2 configured successfully!"
