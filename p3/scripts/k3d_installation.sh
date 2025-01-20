# Installation of k3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# Create the ./kube directory (used for the kubeconfig)
sudo mkdir -p ~/.kube
sudo chmod 700 ~/.kube
sudo chown $USER:$USER ~/.kub

#Installation of kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Create the cluster
sudo k3d cluster create ourCluster

# Get the kubeconfig file from the cluster that I created (for kubectl to connect with the cluster)
sudo k3d kubeconfig get ourCluster > ~/.kube/config

# Create a dedicated namespace for argoCD
kubectl create namespace argocd

# create a namespace called Dev
kubectl create namespace dev

# Installation of argocd inside of the cluster
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Apply the argocd application
kubectl apply -f ../config/application.yaml

# Forwarding the argoCD server to access argoCD UI
kubectl port-forward -n argocd svc/argocd-server 8080:443