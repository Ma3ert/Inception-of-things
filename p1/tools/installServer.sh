apt-get update -y && apt-get install curl
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--disable=traefik" sh -