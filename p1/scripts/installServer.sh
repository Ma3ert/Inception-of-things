# Updating and install dependencies packages
apt-get update -y

# Installation of k3s in server mode
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--disable=traefik" sh -

# Extract the token from the server to the shared folder
sudo cat /var/lib/rancher/k3s/server/node-token > /vagrant_data/node-token

# Set k3s the configuration file
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

# Installation of kubctl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl