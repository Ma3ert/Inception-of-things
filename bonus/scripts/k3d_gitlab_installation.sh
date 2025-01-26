# Installation of k3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# Create the ./kube directory (used for the kubeconfig)
sudo mkdir -p ~/.kube
sudo chmod 700 ~/.kube
sudo chown $USER:$USER ~/.kube

#Installation of kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Create the cluster
sudo k3d cluster create bonusCluster
# sudo k3d cluster create test

# Get the kubeconfig file from the cluster that I created (for kubectl to connect with the cluster)
sudo k3d kubeconfig get bonusCluster > ~/.kube/config
# sudo k3d kubeconfig get test > ~/.kube/config

# Create a dedicated namespace for argoCD
kubectl create namespace argocd

# create a namespace called Dev
kubectl create namespace dev

# Installation of argocd inside of the cluster
#kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Helm installation from the provided script
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

# Create a namespace called gitlab
kubectl create namespace gitlab

# Get the gitlab helm chart
helm repo add gitlab https://charts.gitlab.io/
helm repo update

helm install gitlab gitlab/gitlab \
  -f https://gitlab.com/gitlab-org/charts/gitlab/raw/master/examples/values-minikube-minimum.yaml \
  --set global.hosts.domain="gitlab337.duckdns.org" \
  --set global.edition=ce \
  --set global.hosts.externalIP="64.23.170.41" \
  --set certmanager-issuer.email="yait-iaz@student.1337.ma" \
  --set global.hosts.https="false" \
  --set global.ingress.configureCertmanager=false \
  --set gitlab-runner.install=false \
  --namespace gitlab

sudo kubectl wait --for=condition=available deployment/gitlab-webservice-default -n gitlab --timeout=600s
