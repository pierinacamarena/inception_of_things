echo "Updating packages and installing required tools..."
sudo yum update -y
sudo yum install -y curl
sudo yum install -y net-tools

# Install k3s
echo "Installing k3s..."
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--cluster-init --node-ip=$SERVER_IP --flannel-iface=eth1" K3S_KUBECONFIG_MODE="644" sh -s -


mkdir 
# Ensure k3s is ready and apply the Kubernetes manifest
echo "Applying Kubernetes manifest..."
sudo /usr/local/bin/k3s kubectl apply -f /vagrant/setup.yml

echo "Setup complete!"
