      sudo apt-get update
      sudo apt-get install -y curl

      #install kubctl
      curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
      sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
      kubectl version --client

      #install ks3
      curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent" sh -s -S