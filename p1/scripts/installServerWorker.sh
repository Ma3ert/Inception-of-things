# Updating and install dependencies packages
apt-get update -y

# Retrieving the token from the shared folder
TOKEN=$(cat /vagrant_data/node-token | tr -d '\n')

env | grep TOKEN

# Installation of k3s in server mode
curl -sfL https://get.k3s.io | K3S_TOKEN="$TOKEN" K3S_URL=https://192.168.56.110:6443 sh -

# Set k3s the configuration file
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

# Installation of kubctl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl