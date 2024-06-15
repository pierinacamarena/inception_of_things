      sudo apk update                  # Update the package list
      sudo apk add curl                # Install curl
      sudo apk add net-tools           # Install net-tools if necessary

      #install kubctl
      curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
      sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
      kubectl version --client


      # Wait for the node token to be available
      while ! [ -f /vagrant/node-token ]
      do
      sleep 1
      done

      # Read token from shared folder
      TOKEN=$(cat /vagrant/node-token)

      # Install k3s worker
      curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent --server https://$SERVER_IP:6443 --node-ip=$WORKER_IP --flannel-iface=eth1 --token=$TOKEN" sh -s -