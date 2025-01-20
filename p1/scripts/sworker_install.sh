#!/bin/bash

# Read the server token and IP from shared files
TOKEN=$(cat /vagrant/server_token.txt)
SERVER_IP=$(cat /vagrant/server_ip.txt)

# Install K3s in agent (worker) mode
curl -sfL https://get.k3s.io | K3S_URL=https://${SERVER_IP}:6443 K3S_TOKEN=${TOKEN} INSTALL_K3S_EXEC="--flannel-iface=eth1" sh -

echo "K3s agent installation complete."
