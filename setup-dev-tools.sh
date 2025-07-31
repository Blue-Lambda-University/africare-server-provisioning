#!/bin/bash
set -e

echo "🔄 Updating package list..."
sudo apt update

echo "📦 Installing OpenJDK 17..."
sudo apt install -y openjdk-17-jdk

echo "🐳 Installing Docker Engine..."
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo apt install unzip

# Add Docker’s official GPG key
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Add Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable Docker without sudo
if ! groups $USER | grep -q '\bdocker\b'; then
  echo "➕ Adding user '$USER' to 'docker' group..."
  sudo usermod -aG docker $USER
  echo "ℹ️ You must log out and back in for group change to take effect."
fi

echo "🧪 Testing Docker installation..."
docker --version
docker compose version

echo "☁️ Installing AWS CLI v2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
unzip -q /tmp/awscliv2.zip -d /tmp
sudo /tmp/aws/install
rm -rf /tmp/aws /tmp/awscliv2.zip

echo "✅ All tools installed successfully!"
