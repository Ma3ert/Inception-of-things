# Updating and install dependencies packages
apt-get update -y && apt-get install curl

# Installation of k3s in server mode
curl -sfL https://get.k3s.io | K3S_TOKEN=xxx K3S_URL=https://server-url:6443 sh -

# Installation of kubctl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl