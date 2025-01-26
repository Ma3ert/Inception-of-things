# Get the kubeconfig file from the cluster that I created (for kubectl to connect with the cluster)
sudo k3d kubeconfig get bonusCluster > ~/.kube/config

# Installation of argocd inside of the cluster
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Apply the argocd application
kubectl apply -f ../config/application.yaml

#wait for the argocd server
sudo kubectl wait --for=condition=available deployment/argocd-server -n argocd --timeout=600s