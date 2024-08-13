apt-get update -y && apt-get install curl
curl -sfL https://get.k3s.io | K3S_TOKEN=xxx K3S_URL=https://server-url:6443 sh -