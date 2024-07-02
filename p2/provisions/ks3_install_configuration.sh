# echo "Updating packages and installing required tools..."
# systemctl disable firewalld --now
# echo "DONE DISABLING"

# sudo yum update -y
# echo "INSTALL 1"

# sudo yum install -y curl
# echo "INSTALL 2"

# echo "INSTALLING  NET TOOLS"
# sudo yum install -y net-tools
# echo "DONE INSTALLNG NET TOOLS"
set -e  # Exit on error

echo "Updating APK and installing packages..."
sudo apk update
sudo apk add curl
sudo apk add net-tools
sudo apk add nginx


# Install k3s
echo "Installing k3s..."
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --node-ip=$SERVER_IP --flannel-iface=eth1" K3S_KUBECONFIG_MODE="644" sh -s -

echo "DONE INSTALLING K3S"
# mkdir 
# Ensure k3s is ready and apply the Kubernetes manifest
echo "Applying Kubernetes manifest..."
sleep 30 
sudo /usr/local/bin/k3s kubectl apply -f /vagrant/app1/app1.deployment.yaml
sudo /usr/local/bin/k3s kubectl apply -f /vagrant/app1/app1.service.yaml
sudo /usr/local/bin/k3s kubectl apply -f /vagrant/app1/app1.ingress.yaml
sudo /usr/local/bin/k3s kubectl apply -f /vagrant/app1/app1.configmap.yaml


# sudo /usr/local/bin/k3s kubectl apply -f /vagrant/app2/app2.deployment.yaml
# sudo /usr/local/bin/k3s kubectl apply -f /vagrant/app2/app2.service.yaml
# sudo /usr/local/bin/k3s kubectl apply -f /vagrant/app2/app2.ingress.yaml
# sudo /usr/local/bin/k3s kubectl apply -f /vagrant/app2/app2.configmap.yaml


# sudo /usr/local/bin/k3s kubectl apply -f /vagrant/app3/app3.deployment.yaml
# sudo /usr/local/bin/k3s kubectl apply -f /vagrant/app3/app3.service.yaml
# sudo /usr/local/bin/k3s kubectl apply -f /vagrant/app3/app3.ingress.yaml
# sudo /usr/local/bin/k3s kubectl apply -f /vagrant/app3/app3.configmap.yaml


echo "Setup complete!"
