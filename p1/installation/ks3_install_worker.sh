
      sudo apk update || { echo "Failed to update APK indices"; exit 1; }
      sudo apk add curl || { echo "Failed to install curl"; exit 1; }
      sudo apk add net-tools || { echo "Failed to install net-tools"; exit 1; }

      # Wait for the node token to be available
      while ! [ -f /vagrant/node-token ]
      do
            echo "sleeping until getting token"
            sleep 1
      done

      # Read token from shared folder
      TOKEN=$(cat /vagrant/node-token) || { echo "Failed to read token"; exit 1; }

      # Install k3s worker
      curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent --server=https://$SERVER_IP:6443 --node-ip=$WORKER_IP --flannel-iface=eth1 --token=$TOKEN" K3S_KUBECONFIG_MODE="644"  sh -s -
