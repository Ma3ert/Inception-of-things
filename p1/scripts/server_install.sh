#!/bin/bash

# Install K3s in server (controller) mode
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--bind-address=${SERVER_IP} --flannel-iface=eth1" sh -

# Output the token to a shared location for the agent to access
TOKEN_FILE=/vagrant/server_token.txt
sudo cat /var/lib/rancher/k3s/server/node-token > $TOKEN_FILE

# Output the server's private IP for the agent
SERVER_IP=$1
echo "$SERVER_IP" > /vagrant/server_ip.txt

echo "K3s server installation complete."
