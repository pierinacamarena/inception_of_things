      sudo apk update                  # Update the package list
      sudo apk add curl                # Install curl
      sudo apk add net-tools           # Install net-tools if necessary

      #install kubctl
      curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
      sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
      kubectl version --client

      curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --node-ip=$SERVER_IP --flannel-iface=eth1"  sh -s -
      
      while ! [ -f /var/lib/rancher/k3s/server/node-token ]
      do
            sleep 1
      done
      cp /var/lib/rancher/k3s/server/node-token /vagrant