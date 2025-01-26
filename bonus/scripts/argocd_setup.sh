# Get the kubeconfig file from the cluster that I created (for kubectl to connect with the cluster)
sudo k3d kubeconfig get bonusCluster > ~/.kube/config

# Installation of argocd inside of the cluster
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Apply the argocd application
kubectl apply -f ../config/application.yaml

#wait for the argocd server
sudo kubectl wait --for=condition=available deployment/argocd-server -n argocd --timeout=600s

# kubectl port-forward --address 0.0.0.0 -n argocd svc/argocd-server 8080:443
# kubectl get secret argocd-initial-admin-secret -n argocd -o yaml | grep " password:" | cut -d ":" -f 2 | cut -d " " -f 2 | base64 --decode && echo