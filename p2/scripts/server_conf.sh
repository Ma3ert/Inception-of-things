#!/bin/bash
SERVER_IP=$1
# Install K3s in server (controller) mode
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--bind-address=${SERVER_IP} --flannel-iface=eth1" sh -

echo "K3s server installation complete."

# Install apps
sudo sh /vagrant/scripts/apps_setups.sh