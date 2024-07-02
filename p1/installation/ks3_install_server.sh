
#!/bin/sh
set -e  # Exit on error

echo "Updating APK and installing packages..."
sudo apk update
sudo apk add curl
sudo apk add net-tools

echo "k3s installation on node"
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --node-ip=$SERVER_IP --flannel-iface=eth1" K3S_KUBECONFIG_MODE="644" sh -s -


echo "Waiting for k3s to complete installation..."
while ! sudo [ -f /var/lib/rancher/k3s/server/node-token ]
do
    sleep 1
done

echo "Copying node-token to /vagrant..."
sudo cp /var/lib/rancher/k3s/server/node-token /vagrant/
echo "Finished copying token"


echo "Installation and configuration completed successfully."
