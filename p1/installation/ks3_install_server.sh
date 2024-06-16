      # sudo apk update                  # Update the package list
      # sudo apk add curl                # Install curl
      # sudo apk add net-tools           # Install net-tools if necessary

      # #install kubctl
      # curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
      # sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
      # kubectl version --client

      # echo "k3s installation on node"
      # echo "server is ${SERVER_IP}"
      # curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --node-ip=$SERVER_IP --flannel-iface=eth1"  sh -s -
      
      # while ! [ -f /var/lib/rancher/k3s/server/node-token ]
      # do
      #       sleep 1
      # done
      # cp /var/lib/rancher/k3s/server/node-token /vagrant


#!/bin/sh
set -e  # Exit on error

# Ensure SERVER_IP is defined
echo "Updating APK and installing packages..."
sudo apk update
sudo apk add curl
sudo apk add net-tools

echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client

echo "k3s installation on node with IP: $SERVER_IP"
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --node-ip=$SERVER_IP --flannel-iface=eth1" sh -s -

echo "Configuring kubectl..."
# export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
# echo 'export KUBECONFIG=/etc/rancher/k3s/k3s.yaml' >> ~/.profile

echo "Waiting for k3s to complete installation..."
while ! [ -f /var/lib/rancher/k3s/server/node-token ]
do
    sleep 1
done
cp /var/lib/rancher/k3s/server/node-token /vagrant

# echo "Verifying k3s installation..."
# until kubectl get nodes; do
#     echo "Waiting for k3s to be fully operational..."
#     sleep 5
# done

echo "Installation and configuration completed successfully."
